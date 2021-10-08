using JuMP
using Clp

LARGE_VALUE = 100000
DEMANDS = [400 300 420 380]
SUPPLY = [500, 600, 200, 300]
COSTS = [100 103 106 109; 
        LARGE_VALUE 140 143 146; 
        LARGE_VALUE LARGE_VALUE 120 123; 
        LARGE_VALUE LARGE_VALUE LARGE_VALUE 150]

m = Model(Clp.Optimizer)
@variable(m, x[1:4, 1:4] ≥ 0)
@objective(m, Min, sum(COSTS .* x))
@constraint(m, sum(x, dims=2) .≤ SUPPLY)
@constraint(m, sum(x, dims=1) .== DEMANDS)
print(m)
optimize!(m)
status = termination_status(m)
println("Solution status: ", status)
println("Objective value: ", objective_value(m))
println("Values: ", value.(x))