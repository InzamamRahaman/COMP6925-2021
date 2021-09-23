using JuMP
using Clp

PROPORTION_MAT = [
    [5.0 15.0]
    [20.0 5.0]
    [-15.0 -2.0]
]

LIMITS = [50.0, 40.0, -60.0]

COSTS = [8.0, 4.0]

m = Model(Clp.Optimizer)
@variable(m, x[1:2] >= 0)
@objective(m, Min, COSTS' * x)
@constraint(m, PROPORTION_MAT * x .≥ LIMITS)

print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))

println("Values: ", value.(x))
