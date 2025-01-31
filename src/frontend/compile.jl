struct ModuleTarget
  extinst_imports::Dictionary{String,ResultID}
  types::BijectiveMapping{ResultID,SPIRType}
  constants::BijectiveMapping{ResultID,Constant}
  global_vars::BijectiveMapping{ResultID,Variable}
  fdefs::BijectiveMapping{ResultID,FunctionDefinition}
  metadata::ResultDict{Metadata}
  debug::DebugInfo
  idcounter::IDCounter
end

@forward_methods ModuleTarget field = :metadata metadata!(_, args...) decorations!(_, args...) decorations(_, args...) has_decoration(_, args...) decorate!(_, args...)

ModuleTarget() = ModuleTarget(Dictionary(), BijectiveMapping(), BijectiveMapping(), BijectiveMapping(), BijectiveMapping(), ResultDict(), DebugInfo(), IDCounter(0))

GlobalsInfo(mt::ModuleTarget) = GlobalsInfo(mt.types, mt.constants, mt.global_vars)

function set_name!(mt::ModuleTarget, id::ResultID, name::Symbol)
  set!(mt.debug.names, id, name)
  set_name!(metadata!(mt.metadata, id), name)
end

struct Translation
  args::Dictionary{Core.Argument,ResultID}
  "Result IDs for basic blocks from Julia IR."
  bbs::BijectiveMapping{Int,ResultID}
  "Result IDs for each `Core.SSAValue` that implicitly represents a basic block."
  bb_results::Dictionary{Core.SSAValue,ResultID}
  "Result IDs that correspond semantically to `Core.SSAValue`s."
  results::Dictionary{Core.SSAValue,ResultID}
  "Intermediate results that correspond to SPIR-V `Variable`s. Typically, these results have a mutable Julia type."
  variables::Dictionary{Core.SSAValue,Variable}
  tmap::TypeMap
  "SPIR-V types derived from Julia types."
  types::Dictionary{DataType,ResultID}
  globalrefs::Dictionary{Core.SSAValue,GlobalRef}
end

Translation(tmap, types) = Translation(Dictionary(), BijectiveMapping(), Dictionary(), Dictionary(), Dictionary(), tmap, types, Dictionary())
Translation() = Translation(TypeMap(), Dictionary())

ResultID(arg::Core.Argument, tr::Translation) = tr.args[arg]
ResultID(bb::Int, tr::Translation) = tr.bbs[bb]
ResultID(val::Core.SSAValue, tr::Translation) = tr.results[val]

function compile(@nospecialize(f), @nospecialize(argtypes = Tuple{}), args...; interp = SPIRVInterpreter())
  compile(SPIRVTarget(f, argtypes; interp), args...)
end

compile(target::SPIRVTarget, args...) = compile!(ModuleTarget(), Translation(), target, args...)

function compile!(mt::ModuleTarget, tr::Translation, target::SPIRVTarget, variables::Dictionary{Int,Variable} = Dictionary{Int,Variable}())
  # TODO: restructure CFG
  emit!(mt, tr, target, variables)
  mt
end

function compile!(mt::ModuleTarget, tr::Translation, target::SPIRVTarget, features::FeatureSupport, variables = Dictionary{Int,Variable}())
  mt = compile!(mt, tr, target, variables)
  ir = IR(mt, tr)
  satisfy_requirements!(ir, features)
end

function IR(mt::ModuleTarget, tr::Translation)
  ir = IR()
  merge!(ir.extinst_imports, mt.extinst_imports)
  ir.types = mt.types
  ir.constants = mt.constants
  ir.global_vars = mt.global_vars
  ir.fdefs = mt.fdefs
  ir.debug = mt.debug
  ir.idcounter = mt.idcounter
  ir.tmap = tr.tmap
  ir.metadata = mt.metadata
  fill_phi_branches!(ir)
end

mutable struct CompilationError <: Exception
  msg::String
  target::SPIRVTarget
  jinst::Any
  jtype::Type
  ex::Expression
  CompilationError(msg::AbstractString) = (err = new(); err.msg = msg; err)
end

function throw_compilation_error(exc::Exception, fields::NamedTuple, msg = "the following method instance could not be compiled to SPIR-V")
  if isa(exc, CompilationError)
    for (prop, val) in pairs(fields)
      setproperty!(exc, prop, val)
    end
    rethrow()
  else
    err = CompilationError(msg)
    for (prop, val) in pairs(fields)
      setproperty!(err, prop, val)
    end
    throw(err)
  end
end
throw_compilation_error(msg::AbstractString) = throw(CompilationError(msg))

error_field(field) = string(Base.text_colors[:cyan], field, Base.text_colors[:default], ": ")

function Base.showerror(io::IO, err::CompilationError)
  # TODO: Use Base.StackTraces.
  if isdefined(err, :target)
    println(io, "An error occurred while compiling a `CodeInfo`.")
    show_debug_code(io, err.target.code)
  end
  print(io, "CompilationError")
  print(io, ": ", err.msg, '.')
  (; stacktrace) = err.target.interp.debug
  print(io, "\nStacktrace:")
  for (i, frame) in enumerate(reverse(stacktrace))
    here = i == firstindex(stacktrace)
    println(io)
    here ? printstyled(io, '>'; color = :red, bold = true) : print(io, ' ')
    print(io, " [$i] ")
    str = string(frame.mi, "::", frame.code.rettype)
    here ? printstyled(io, str; color = :red, bold = true) : print(io, str)
  end
  frame = last(stacktrace)
  frame.code.rettype == Union{} && length(frame.code.code) < 100 && println(io, "\n\n", frame.code)
  if isdefined(err, :jinst)
    print(io, "\n\n", error_field("Julia instruction"), err.jinst, Base.text_colors[:yellow], "::", err.jtype, Base.text_colors[:default])
  end
  if isdefined(err, :ex)
    print(io, "\n\n", error_field("Wrapped SPIR-V expression"))
    emit(io, err.ex)
  end
  println(io)
end

function emit!(mt::ModuleTarget, tr::Translation, target::SPIRVTarget, variables = Dictionary{Int,Variable}())
  push!(target.interp.debug.stacktrace, DebugFrame(target.mi, target.code))
  # Declare a new function.
  local fdef
  try
    # Fill the SPIR-V function with instructions generated from the target's inferred code.
    fdef = define_function!(mt, tr, target, variables)
  catch e
    throw_compilation_error(e, (; target))
  end
  fid = emit!(mt, tr, fdef)
  set_name!(mt, fid, mangled_name(target.mi))
  arg_idx = 0
  gvar_idx = 0
  for (i, t) in enumerate(target.mi.specTypes.types[2:end])
    t <: Type && continue
    argid = haskey(variables, i) ? fdef.global_vars[gvar_idx += 1] : fdef.args[arg_idx += 1]
    insert!(tr.args, Core.Argument(i + 1), argid)
    set_name!(mt, argid, target.code.slotnames[i + 1])
  end

  try
    # Fill the SPIR-V function with instructions generated from the target's inferred code.
    emit!(fdef, mt, tr, target)
  catch e
    throw_compilation_error(e, (; target))
  end
  pop!(target.interp.debug.stacktrace)
  fid
end

function mangled_name(mi::MethodInstance)
  Symbol(replace(string(mi.def.name, '_', Base.tuple_type_tail(mi.specTypes)), ' ' => ""))
end

function define_function!(mt::ModuleTarget, tr::Translation, target::SPIRVTarget, variables::Dictionary{Int,Variable})
  argtypes = SPIRType[]
  global_vars = ResultID[]
  (; mi) = target

  for (i, t) in enumerate(mi.specTypes.types[2:end])
    t <: Type && continue
    type = spir_type(t, tr.tmap; wrap_mutable = true)
    var = get(variables, i, nothing)
    @switch var begin
      @case ::Nothing
      push!(argtypes, type)
      @case ::Variable
      @switch var.storage_class begin
        @case &StorageClassFunction
        push!(argtypes, type)
        @case ::StorageClass
        push!(global_vars, emit!(mt, tr, var))
      end
    end
  end
  ci = target.interp.global_cache[mi]
  ftype = FunctionType(spir_type(ci.rettype, tr.tmap), argtypes)
  FunctionDefinition(ftype, FunctionControlNone, [], [], ResultDict(), [], global_vars)
end

function emit!(mt::ModuleTarget, tr::Translation, fdef::FunctionDefinition)
  emit!(mt, tr, fdef.type)
  fid = next!(mt.idcounter)
  append!(fdef.args, next!(mt.idcounter) for _ = 1:length(fdef.type.argtypes))
  insert!(mt.fdefs, fdef, fid)
  fid
end

emit!(mt::ModuleTarget, tr::Translation, @nospecialize(type::SPIRType)) = emit_type!(mt.types, mt.idcounter, mt.constants, tr.tmap, type)
emit!(mt::ModuleTarget, tr::Translation, c::Constant) = emit_constant!(mt.constants, mt.idcounter, mt.types, tr.tmap, c)

emit_constant!(mt::ModuleTarget, tr::Translation, value) = emit_constant!(mt.constants, mt.idcounter, mt.types, tr.tmap, Constant(value, mt, tr))

function Constant(value::T, mt::ModuleTarget, tr::Translation) where {T}
  t = spir_type(T, tr.tmap)
  !iscomposite(t) && return Constant(value, t)
  ids = @match value begin
    ::Union{Vec,Arr} => [emit_constant!(mt, tr, value[i]) for i in eachindex(value)]
    ::Mat => [emit_constant!(mt, tr, col) for col in columns(mat)]
    _ => [emit_constant!(mt, tr, getproperty(value, name)) for name in fieldnames(T)]
  end 
  Constant(ids, t)
end

function emit!(mt::ModuleTarget, tr::Translation, var::Variable)
  haskey(mt.global_vars, var) && return mt.global_vars[var]
  emit!(mt, tr, var.type)
  id = next!(mt.idcounter)
  insert!(mt.global_vars, var, id)
  id
end

function emit!(fdef::FunctionDefinition, mt::ModuleTarget, tr::Translation, target::SPIRVTarget)
  ranges = block_ranges(target)
  back_edges = backedges(target.cfg)
  vs = traverse(target.cfg)
  add_mapping!(tr, mt.idcounter, ranges, vs)
  emit_nodes!(fdef, mt, tr, target, ranges, vs, back_edges)
  replace_forwarded_ssa!(fdef, tr)
end

function add_mapping!(tr::Translation, counter::IDCounter, ranges, vs)
  for v in vs
    id = next!(counter)
    insert!(tr.bbs, v, id)
    insert!(tr.bb_results, Core.SSAValue(first(ranges[v])), id)
  end
end

function emit_nodes!(fdef::FunctionDefinition, mt::ModuleTarget, tr::Translation, target::SPIRVTarget, ranges, vs, backedges)
  for v in vs
    emit!(fdef, mt, tr, target, ranges[v], v)
  end
end

"""
Replace forward references to `Core.SSAValue`s by their appropriate `ResultID`.
"""
function replace_forwarded_ssa!(fdef::FunctionDefinition, tr::Translation)
  for block in fdef
    for ex in block
      for (i, arg) in enumerate(ex)
        isa(arg, Core.SSAValue) && (ex[i] = ResultID(arg, tr))
      end
    end
  end
end

follow_globalref(@nospecialize x) = x
function follow_globalref(x::GlobalRef)
  isdefined(x.mod, x.name) || throw_compilation_error("undefined global reference `$x`")
  getproperty(x.mod, x.name)
end

function emit!(fdef::FunctionDefinition, mt::ModuleTarget, tr::Translation, target::SPIRVTarget, range::UnitRange, node::Integer)
  (; code, ssavaluetypes, slottypes) = target.code
  blk = new_block!(fdef, ResultID(node, tr))
  for i in range
    jinst = code[i]
    # Ignore single `nothing::Nothing` instructions.
    # They seem to be only here as part of dummy basic blocks
    # for instructions such as `OpPhi`.
    # Actual `nothing` arguments are passed by symbol directly.
    (isnothing(jinst) || jinst === GlobalRef(Base, :nothing)) && continue
    Meta.isexpr(jinst, :loopinfo) && continue
    Meta.isexpr(jinst, :coverage) && continue
    jtype = ssavaluetypes[i]
    isa(jtype, Core.PartialStruct) && (jtype = jtype.typ)
    isa(jtype, Core.Const) && (jtype = typeof(jtype.val))
    core_ssaval = Core.SSAValue(i)
    ex = nothing
    try
      @switch jinst begin
        @case ::Core.ReturnNode
        ex = @match follow_globalref(jinst.val) begin
          ::Nothing => @ex OpReturn()
          val => begin
            args = Any[val]
            load_variables!(args, blk, mt, tr, fdef, OpReturnValue)
            remap_args!(args, mt, tr, OpReturnValue)
            @ex OpReturnValue(only(args))
          end
        end
        add_expression!(blk, tr, ex, core_ssaval)
        @case ::Core.GotoNode
        dest = tr.bb_results[Core.SSAValue(jinst.label)]
        ex = @ex OpBranch(dest)
        add_expression!(blk, tr, ex, core_ssaval)
        @case ::Core.GotoIfNot
        # Core.GotoIfNot uses the SSA value of the first instruction of the target
        # block as its `dest`.
        dest = tr.bb_results[Core.SSAValue(jinst.dest)]
        (; cond) = jinst
        cond_id = isa(cond, Bool) ? emit!(mt, tr, Constant(cond)) : ResultID(cond, tr)
        ex = @ex OpBranchConditional(cond_id, ResultID(node + 1, tr), dest)
        add_expression!(blk, tr, ex, core_ssaval)
        @case _
        if isa(jinst, GlobalRef)
          value = follow_globalref(jinst)
          if isa(value, UnionAll) || isa(value, DataType)
            # Just keep references to types for later.
            insert!(tr.globalrefs, core_ssaval, jinst)
            continue
          else
            jtype === Any && throw_compilation_error("got a `GlobalRef` inferred as `Any`; the global might not have been declared as `const`")
          end
        end
        if ismutabletype(jtype)
          # OpPhi will reuse existing variables, no need to allocate a new one.
          !isa(jinst, Core.PhiNode) && allocate_variable!(mt, tr, fdef, jtype, core_ssaval)
        end
        ret, stype = emit_expression!(mt, tr, target, fdef, jinst, jtype, blk)
        if isa(ret, Expression)
          if ismutabletype(jtype) && !isa(jinst, Core.PhiNode)
            # The current core ResultID has already been assigned (to the variable).
            add_expression!(blk, tr, ret, nothing)
            # Store to the new variable.
            add_expression!(blk, tr, @ex OpStore(tr.results[core_ssaval], ret.result::ResultID))
          elseif ismutabletype(jtype) && isa(jinst, Core.PhiNode)
            insert!(tr.variables, core_ssaval, Variable(stype, StorageClassFunction))
            add_expression!(blk, tr, ret, core_ssaval)
          else
            add_expression!(blk, tr, ret, core_ssaval)
          end
        elseif isa(ret, ResultID)
          # The value is a SPIR-V global (possibly a constant),
          # so no need to push a new expression.
          # Just map the current SSA value to the global.
          # If the instruction was a `GlobalRef` then we'll already have inserted the result.
          !isa(jinst, GlobalRef) && insert!(tr.results, core_ssaval, ret)
        end
      end
    catch e
      fields = (; jinst, jtype)
      !isnothing(ex) && (fields = (; fields..., ex))
      throw_compilation_error(e, fields)
    end
  end

  # Implicit `goto` to the next block.
  if !is_termination_instruction(last(blk))
    ex = @ex OpBranch(ResultID(node + 1, tr))
    add_expression!(blk, tr, ex)
  end
end

function allocate_variable!(mt::ModuleTarget, tr::Translation, fdef::FunctionDefinition, jtype::Type, core_ssaval::Core.SSAValue)
  # Create a SPIR-V variable to allow for future mutations.
  id = next!(mt.idcounter)
  type = PointerType(StorageClassFunction, spir_type(jtype, tr.tmap))
  var = Variable(type)
  emit!(mt, tr, type)
  insert!(tr.variables, core_ssaval, var)
  insert!(tr.results, core_ssaval, id)
  push!(fdef.local_vars, Expression(var, id))
end

function add_expression!(block::Block, tr::Translation, ex::Expression, core_ssaval::Optional{Core.SSAValue} = nothing)
  if !isnothing(ex.result) && !isnothing(core_ssaval)
    insert!(tr.results, core_ssaval, ex.result)
  end
  push!(block, ex)
end

function emit_extinst!(mt::ModuleTarget, extinst)
  haskey(mt.extinst_imports, extinst) && return mt.extinst_imports[extinst]
  id = next!(mt.idcounter)
  insert!(mt.extinst_imports, extinst, id)
  id
end

macro compile(features, interp, ex)
  compile_args = map(esc, get_signature(ex))
  :(compile($(compile_args...), $(esc(features)); interp = $(esc(interp))))
end

macro compile(interp, ex)
  esc(:($(@__MODULE__).@compile $(AllSupported()) $interp $ex))
end
macro compile(ex)
  esc(:($(@__MODULE__).@compile $(AllSupported()) $(SPIRVInterpreter()) $ex))
end

function getline(code::CodeInfo, i::Int)
  codeloc = code.codelocs[i]
  iszero(codeloc) && return nothing
  line = code.linetable[codeloc]
end

function validate(code::CodeInfo)::Result{Bool,ValidationError}
  globalrefs = Dictionary{Core.SSAValue, GlobalRef}()
  validation_error(msg, i, ex, line) = ValidationError(string(msg, " in expression `", ex, "` at code location ", i, " around ", line.file, ":", line.line, '\n'))
  for (i, ex) in enumerate(code.code)
    ex === nothing && continue
    isa(ex, GlobalRef) && insert!(globalrefs, Core.SSAValue(i), ex)
    line = getline(code, i)
    !isnothing(line) || error("No code location was found at code location $i for ex $ex; make sure to provide a `CodeInfo` which was generated with debugging info (`debuginfo = :source`).")
    @trymatch ex begin
      &Core.ReturnNode() => return validation_error("Unreachable statement detected (previous instruction: $(code.code[i - 1]))", i, ex, line)
      Expr(:foreigncall, _...) => return validation_error("Foreign call detected", i, ex, line)
      Expr(:call, f, _...) => @match follow_globalref(f) begin
        &Base.not_int || &Base.bitcast || &Base.getfield || &Core.tuple => nothing
        ::Core.IntrinsicFunction => return validation_error("Illegal core intrinsic function `$f` detected", i, ex, line)
        ::Function => return validation_error("Dynamic dispatch detected", i, ex, line)
        _ => return validation_error("Expected `GlobalRef`", i, ex, line)
      end
      Expr(:invoke, mi, f, _...) => begin
        mi::MethodInstance
        isa(f, Core.SSAValue) && (f = globalrefs[f])
        isa(f, GlobalRef) && (f = follow_globalref(f))
        f === throw && return validation_error("An exception may be throwned", i, ex, line)
        in(mi.def.module, (Base, Core)) && return validation_error("Invocation of a `MethodInstance` detected that is defined in Base or Core (they should be inlined)", i, ex, line)
      end
    end
  end

  # Validate types in a second pass so that we can see things such as unreachable statements and exceptions before
  # raising an error because e.g. a String type is detected when building the error message.
  for (i, ex) in enumerate(code.code)
    isa(ex, Union{Core.ReturnNode, Core.GotoNode, Core.GotoIfNot, Nothing}) && continue
    T = code.ssavaluetypes[i]
    isa(ex, GlobalRef) && isa(T, Type) && continue
    Meta.isexpr(ex, :invoke) && ex.args[2] == GlobalRef(@__MODULE__, :Store) && continue
    line = getline(code, i)
    @trymatch T begin
      ::Type{Union{}} => return validation_error("Bottom type Union{} detected", i, ex, line)
      ::Type{<:AbstractString} => return validation_error("String type `$T` detected", i, ex, line)
      ::Type{Any} => return validation_error("Type `Any` detected", i, ex, line)
      ::Type{<:UnionAll} => return validation_error("`UnionAll` detected", i, ex, line)
      ::Type{T} => @trymatch T begin
        GuardBy(isabstracttype) => return validation_error("Abstract type `$T` detected", i, ex, line)
        GuardBy(!isconcretetype) => return validation_error("Non-concrete type `$T` detected", i, ex, line)
      end
    end
  end

  for (i, ex) in enumerate(code.code)
    !Meta.isexpr(ex, :invoke) && continue
    T = code.ssavaluetypes[i]
    line = getline(code, i)
    mi = ex.args[1]
    if mi.def.module === SPIRV
      opcode = lookup_opcode(mi.def.name)
      isnothing(opcode) && return validation_error("Invocation of a `MethodInstance` defined in module SPIRV that does not correspond to an opcode (they should be inlined to ones that correspond to opcodes)", i, ex, line)
    end
  end

  true
end

function FunctionDefinition(mt::ModuleTarget, name::Symbol)
  for (id, val) in pairs(mt.debug.names)
    if val == name && haskey(mt.fdefs, id)
      return mt.fdefs[id]
    end
  end
  error("No function named '$name' could be found.")
end

FunctionDefinition(mt::ModuleTarget, mi::MethodInstance) = FunctionDefinition(mt, mangled_name(mi))
