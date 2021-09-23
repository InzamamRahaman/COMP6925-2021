using JuMP
using Clp
using Cbc


m = Model(Cbc.Optimizer)
@variable(m, fa >= 0, Int)
@variable(m, fb >= 0, Int)
@variable(m, pa >= 0, Int)
@variable(m, pb >= 0, Int)
@variable(m, pc >= 0, Int)
@variable(m, pd >= 0, Int)

@objective(m, Min, 320 * (fa + fb) + 120 * (pa + pb + pc + pd))
@constraint(m, fa + pa >= 4)
@constraint(m, fa + pb >= 8)
@constraint(m, fb + pc >= 10)
@constraint(m, fb + pd >= 8)
@constraint(m, fa >= 2pa)
@constraint(m, fa >= 2pb)
@constraint(m, fb >= 2pc)
@constraint(m, fb >= 2pd)

print(m)
optimize!(m)
status = termination_status(m)
println("Solution status: ", status)

println("Objective value: ", objective_value(m))

println("Full-time consultants for shift 1: ", value(fa))
println("Full-time consultants for shift 2: ", value(fb))
println("Part-time consultants for shift 1: ", value(pa))
println("Part-time consultants for shift 2: ", value(pd))
println("Part-time consultants for shift 3: ", value(pc))
println("Part-time consultants for shift 4: ", value(pd))
