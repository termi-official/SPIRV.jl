function restructure!(cfg::CFG)
    restructure_loops!(cfg)
    cfg
end

function restructure_loops!(cfg::CFG)
    is_single_entry_single_exit(cfg) || error("Loop restructuring requires the CFG to be single entry, single exit.")
    g = cfg.graph
    vs = vertices(g)

    entry_nodes = sources(g)
    @assert length(entry_nodes) == 1
    entry = entry_nodes[]

    exit_nodes = sinks(g)
    @assert length(exit_nodes) == 1
    exit = exit_nodes[]

    sccs = strongly_connected_components(g)
end

# this spits out untyped code, which is not good!
function merge_return_blocks(cfg::CFG)
    b = Builder(cfg.code)
    new_block = last(vertices(cfg.graph)) + 1
    rvals = []
    redges = Variable[]
    for (v, st) in b
        b[v] = st
        @switch st begin
            @case ::Core.ReturnNode
                push!(rvals, st.val)
                push!(redges, v)
            @case _
                nothing
        end
    end
    phi_id = length(b) + 1
    for v in redges
        b[v] = Core.GotoNode(phi_id)
    end
    push!(b, Core.PhiNode(Int32.(getproperty.(redges, :id)), rvals))
    push!(b, Core.ReturnNode(Variable(phi_id)))

    CFG(finish(b))
end
