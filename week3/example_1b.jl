using JuMP
using Clp
COSTS = [80 215; 100 108; 102 68]
LIMITS = [1000, 1500, 1200]
DEMANDS = [2300 1400]
m = Model(Clp.Optimizer)
@variable(m, x[1:3, 1:2] ≥ 0)
@objective(m, Min, sum(COSTS .* x))
@constraint(m, sum(x, dims=2) .≤ LIMITS)
@constraint(m, sum(x, dims=1) .== DEMANDS)
print(m)
optimize!(m)
status = termination_status(m)
println("Solution status: ", status)
println("Objective value: ", objective_value(m))