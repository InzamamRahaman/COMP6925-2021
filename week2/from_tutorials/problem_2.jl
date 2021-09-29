using JuMP
using Clp


m = Model(Clp.Optimizer)

@variable(m, x₁ ≥ 0)
@variable(m, x₂ ≥ 0)
@variable(m, x₃ ≥ 0)

@objective(m, Max, 2x₁  + 4x₂ + 3x₃)
@constraint(m, 3x₁  + 4x₂ + 2x₃ ≤ 60)
@constraint(m, 2x₁  + x₂ + 2x₃ ≤ 40)
@constraint(m, x₁  + 3x₂ + 2x₃ ≤ 80)

print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))
println("x₁ = ", value(x₁))
println("x₂ = ", value(x₂))
println("x₃ = ", value(x₃))
