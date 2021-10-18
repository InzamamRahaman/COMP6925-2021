using JuMP
using Cbc
m = Model(Cbc.Optimizer)

PROFIT = [15 12 16 18 9 11]
COSTS = [38 33 39 45 23 27]
LIMIT = 100

@variable(m, projects[1:6] ≥ 0, Int)
@objective(m, Max, sum(PROFIT * projects))
@constraint(m, sum(COSTS * projects) ≤ LIMIT)
@constraint(m, projects[1] + projects[2] ≤ 1) # can only choose one of 1 or 2
@constraint(m, projects[3] + projects[4] ≤ 1) # can only choose one of 3 or 4
@constraint(m, projects[3] + projects[4] ≤ projects[1] + projects[2]) # we can do 3 or 4 only if we do 1 or 2
@constraint(m, projects .≤ ones(size(projects))) # can do every project at most once
print(m)
optimize!(m) 
status = termination_status(m)
println("Solution status: ", status)
println("Objective value: ", objective_value(m))
println("Projects chores: ", value.(projects))