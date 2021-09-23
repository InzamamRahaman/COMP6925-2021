using JuMP
using Clp

CARBS = 50
PROTEIN = 40
FAT = 60

m = Model(Clp.Optimizer)

@variable(m, steak ≥ 0)
@variable(m, potatoes ≥ 0)

@objective(m, Min, 8 * steak + 4 * potatoes)




@constraint(m, 5 * steak + 15 * potatoes ≥ CARBS)
@constraint(m, 20 * steak + 5 * potatoes ≥ PROTEIN)
@constraint(m, 15 * steak + 2 * potatoes ≤ FAT)

print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))
println("potatoes = ", value(steak))
println("steak = ", value(potatoes))
