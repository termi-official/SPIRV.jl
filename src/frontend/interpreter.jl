struct SPIRVInterpreter <: AbstractInterpreter
    cache::Vector{InferenceResult}
    world::UInt
    inf_params::InferenceParams
    opt_params::OptimizationParams
end

# Constructor adapted from Julia's `NativeInterpreter`.
function SPIRVInterpreter(world::UInt = get_world_counter(); inf_params = InferenceParams(), opt_params = OptimizationParams())
    current_world = get_world_counter()
    if world == typemax(UInt)
        # Sometimes the caller is lazy and passes typemax(UInt).
        # We cap it to the current world age.
        world = current_world
    else
        world ≤ current_world || error("The provided world is too new, expected world ≤ $current_world")
    end

    return SPIRVInterpreter(
        InferenceResult[],
        world,
        inf_params,
        opt_params,
    )
end

struct CodeInstanceCache
    dict::Dict{MethodInstance,Vector{CodeInstance}}
end
CodeInstanceCache() = CodeInstanceCache(Dict())

@forward CodeInstanceCache.dict (Base.get, Base.haskey)

Base.getindex(cache::CodeInstanceCache, mi::MethodInstance) = WorldView(cache, Core.Compiler.WorldRange(mi.def.primary_world, mi.def.deleted_world))[mi]

function Base.setindex!(cache::CodeInstanceCache, ci::CodeInstance, mi::MethodInstance)
    push!(get!(Vector{CodeInstance}, cache.dict, mi), ci)
end

Base.haskey(wvc::WorldView{CodeInstanceCache}, mi::MethodInstance) = !isnothing(get(wvc, mi, nothing))

function Base.get(wvc::WorldView{CodeInstanceCache}, mi::MethodInstance, default)
    cis = get(wvc.cache, mi, CodeInstance[])
    # Iterate code instances in reverse, as the most recent ones
    # are more likely to be valid.
    for ci in reverse(cis)
        if ci.min_world ≤ Core.Compiler.first(wvc.worlds) && Core.Compiler.last(wvc.worlds) ≤ ci.max_world
            return ci
        end
    end
    default
end

function Base.getindex(wvc::WorldView{CodeInstanceCache}, mi::MethodInstance)
    ci = get(wvc, mi, nothing)
    isnothing(ci) && throw(KeyError(mi))
    ci
end

Base.setindex!(wvc::WorldView{CodeInstanceCache}, args...) = setindex!(wvc.cache, args...)

Core.Compiler.get(wvc::WorldView{CodeInstanceCache}, args...) = get(wvc, args...)
Core.Compiler.haskey(wvc::WorldView{CodeInstanceCache}, args...) = haskey(wvc, args...)
Core.Compiler.setindex!(wvc::WorldView{CodeInstanceCache}, args...) = setindex!(wvc, args...)

const GLOBAL_CI_CACHE = CodeInstanceCache()

Core.Compiler.InferenceParams(si::SPIRVInterpreter) = si.inf_params
Core.Compiler.OptimizationParams(si::SPIRVInterpreter) = si.opt_params
Core.Compiler.get_world_counter(si::SPIRVInterpreter) = si.world
Core.Compiler.get_inference_cache(si::SPIRVInterpreter) = si.cache
Core.Compiler.code_cache(si::SPIRVInterpreter) = WorldView(GLOBAL_CI_CACHE, get_world_counter(si))

function Core.Compiler.inlining_policy(si::SPIRVInterpreter, @nospecialize(src), stmt_flag::UInt8,
    mi::MethodInstance, argtypes::Vector{Any})
    if isa(src, CodeInfo) || isa(src, Vector{UInt8})
        src_inferred = ccall(:jl_ir_flag_inferred, Bool, (Any,), src)
        src_inlineable = Core.Compiler.is_stmt_inline(stmt_flag) || ccall(:jl_ir_flag_inlineable, Bool, (Any,), src)
        return src_inferred && src_inlineable ? src : nothing
    elseif src === nothing && Core.Compiler.is_stmt_inline(stmt_flag)
        # if this statement is forced to be inlined, make an additional effort to find the
        # inferred source in the local cache
        # we still won't find a source for recursive call because the "single-level" inlining
        # seems to be more trouble and complex than it's worth
        inf_result = Core.Compiler.cache_lookup(mi, argtypes, Core.Compiler.get_inference_cache(si))
        inf_result === nothing && return nothing
        src = inf_result.src
        if isa(src, CodeInfo)
            src_inferred = ccall(:jl_ir_flag_inferred, Bool, (Any,), src)
            return src_inferred ? src : nothing
        end
    end
end
