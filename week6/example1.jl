using JuMP
using Cbc
m = Model(Cbc.Optimizer)

TIME_TAKEN = [
    4.5 7.8 3.6 2.9;
    4.9 7.2 4.3 3.1;
]

LIMITS = [1;1;1;1]

@variable(m, eve[1:4] ≥ 0, Int)
@variable(m, steve[1:4] ≥ 0, Int)

reoriented_vars = hcat(eve, steve) # horizontally concat eve and steve variables 

@objective(m, Min, sum(TIME_TAKEN .* transpose(reoriented_vars)))
@constraint(m, sum(eve) == 2) # eve must do 2 chores
@constraint(m, sum(steve) == 2) # steve must do 2 chores
@constraint(m, sum(reoriented_vars, dims=2) .== LIMITS) # each chore must have one person assigned to it
@constraint(m, eve .≤ ones(size(eve)))
@constraint(m, steve .≤ ones(size(steve)))
print(m)
optimize!(m) 
status = termination_status(m)
println("Solution status: ", status)
println("Objective value: ", objective_value(m))
println("Eve's chores: ", value.(eve))
println("Steve's chores: ", value.(steve))