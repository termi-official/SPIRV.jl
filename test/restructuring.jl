using SPIRV, Test, Dictionaries
using SPIRV: nesting_levels, merge_blocks, conflicted_merge_blocks, restructure_merge_blocks!, add_merge_headers!, id_bound, nexs

"""
Generate a minimal SPIR-V IR or module which contains dummy blocks realizing the provided control-flow graph.

Blocks that terminate will return a constant in line with its block index, e.g. `c23f0 = 23f0` for the block corresponding to the node 23.
Blocks that branch to more than one target will either branch with a `BranchConditional` (2 targets exactly) or a `Switch` (3 targets or more).
The selectors for conditionals or switches are exposed as function arguments. Note that the argument will be a `Bool` for conditionals and `Int32`
for switches.
"""
function ir_from_cfg(cfg)
  global_decls = quote
    Bool = TypeBool()
    Float32 = TypeFloat(32)
  end

  label(v) = Symbol(:b, v)
  constant(v) = Symbol(:c, v, :f0)
  condition(v) = Symbol(:x, v)

  append!(global_decls.args, :($(constant(v)) = Constant($(v * 1f0))::Float32) for v in sinks(cfg))

  args = [Expr(:(::), condition(v), length(outneighbors(cfg, v)) > 2 ? :Int32 : :Bool) for v in vertices(cfg) if length(outneighbors(cfg, v)) > 1]

  blocks = map(vertices(cfg)) do v
    insts = [:($(label(v)) = OpLabel())]
    out = outneighbors(cfg, v)
    if length(out) == 0
      push!(insts, :(ReturnValue($(constant(v)))))
    elseif length(out) == 1
      push!(insts, :(Branch($(label(only(out))))))
    elseif length(out) == 2
      push!(insts, :(BranchConditional($(condition(v)), $(label(out[1])), $(label(out[2])))))
    else
      for w in outneighbors(cfg, v)
        push!(insts, Expr(:call, :Switch, condition(v), label(first(out)), Iterators.flatten([Int32(w) => label(w) for w in out])...))
      end
    end
  end

  func = :(@function f($(args...))::Float32 begin
    $(foldl(append!, blocks; init = Expr[])...)
  end)

  ex = Expr(:block, global_decls.args..., func)
  load_ir(ex)
end

@testset "Restructuring utilities" begin
  for i in 1:11
    # Skip a few tricky cases for now.
    in(i, (6, 8)) && continue
    ir = ir_from_cfg(getproperty(@__MODULE__, Symbol(:g, i))())
    @test unwrap(validate(ir))
  end

  # Starting module: two conditionals sharing the same merge block.
  ir = ir_from_cfg(g11())
  # Restructure merge blocks.
  fdef = only(ir.fdefs)
  n = nexs(fdef)
  bound = id_bound(ir)
  restructure_merge_blocks!(ir)
  # A new dummy block needs to be inserted (2 instructions), and 2 branching blocks needed to be updated to branch to the new block.
  @test nexs(fdef) == n + 2
  @test id_bound(ir) == ResultID(UInt32(bound) + 1)
  @test unwrap(validate(ir))

  # Add merge headers.
  add_merge_headers!(ir)
  @test nexs(fdef) == n + 4
  @test length(merge_blocks(fdef)) == 2
  @test isempty(conflicted_merge_blocks(fdef))
  @test unwrap(validate(ir))

  # Starting module: A conditional and a loop sharing the same merge block, with the loop inside the conditional.
  ir = ir_from_cfg(g10())
  fdef = only(ir.fdefs)
  n = nexs(fdef)
  bound = id_bound(ir)
  restructure_merge_blocks!(ir)
  # There is only one update to make to the branching node 3.
  @test nexs(fdef) == n + 2
  @test id_bound(ir) == ResultID(UInt32(bound) + 1)
  @test unwrap(validate(ir))

  # Add merge headers.
  add_merge_headers!(ir)
  @test nexs(fdef) == n + 4
  @test length(merge_blocks(fdef)) == 2
  @test isempty(conflicted_merge_blocks(fdef))
  @test unwrap(validate(ir))

  ctree = ControlTree(g11())
  nesting = nesting_levels(ctree)
  @test [last(nesting[index]) for index in 1:6] == [1, 2, 3, 3, 1, 2]
end;
