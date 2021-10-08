import networkx as nx 

G = nx.DiGraph()

EDGES = [
    [0, 1, 8000],
    [0, 2, 18000],
    [0, 3, 31000],
    [1, 2, 10000],
    [1, 3, 21000],
    [2, 3, 12000]
]

for u, v, cost in EDGES:
    G.add_edge(u_of_edge=u, v_of_edge=v, cost=cost)

print(nx.dijkstra_path(G, 0, 3, weight='cost'))