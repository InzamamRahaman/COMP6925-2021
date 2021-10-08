import networkx as nx 
import numpy as np 

G = nx.DiGraph()

EDGES = [
    ['source', 'f1', 250],
    ['source', 'f2', 180],
    ['source', 'f3', 300],
    ['source', 'f4', 400],
    
    ['f1', 't1', 250],
    ['f1', 't2', 250],
    ['f1', 't3', 250],

    ['f2', 't2', 180],
    ['f2', 't3', 180],

    ['f3', 't1', 300],
    ['f3', 't3', 300],
    ['f3', 't4', 300],

    ['f3', 't1', 400],
    ['f3', 't3', 400],
    ['f3', 't4', 400],

    ['t1', 'sink', 200],
    ['t2', 'sink', 150],
    ['t3', 'sink', 350],
    ['t4', 'sink', 100]
]

for u, v, capacity in EDGES:
    G.add_edge(u_of_edge=u, v_of_edge=v, capacity=capacity)

flow_value, flow_dict = nx.maximum_flow(G, "source", "sink")
print('From factory 1 we produce ', flow_dict['f1']['t1'], ' toys of type t1')

print(flow_value)
print(flow_dict)