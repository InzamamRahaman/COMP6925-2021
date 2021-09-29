using JuMP
using Clp


m = Model(Clp.Optimizer)

@variable(m, x₁ ≥ 0)
@variable(m, x₂ ≥ 0)

@objective(m, Max, 3000x₁  + 5000x₂)
@constraint(m, 3x₁ + 2x₂ ≤ 18)
@constraint(m, x₁ ≤ 4)
@constraint(m, x₂ ≤ 6)

print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))
println("x₁ = ", value(x₁))
println("x₂ = ", value(x₂))
