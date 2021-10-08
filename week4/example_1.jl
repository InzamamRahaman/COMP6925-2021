using LightGraphs
using LightGraphsFlows

flow_graph = DiGraph(4) # Create a flow graph
flow_edges = [
    (1,2,10),(1,3,5),(1,4,15),(2,3,4),(2,5,9),
    (2,6,15),(3,4,4),(3,6,8),(4,7,16),(5,6,15),
    (5,8,10),(6,7,15),(6,8,10),(7,3,6),(7,8,10)
]

capacity_matrix = zeros(Int, 8, 8)  # Create a capacity matrix

for e in flow_edges
    u, v, f = e
    add_edge!(flow_graph, u, v)
    capacity_matrix[u,v] = f
end

f, F = maximum_flow(flow_graph, 1, 8, capacity_matrix) # Run 