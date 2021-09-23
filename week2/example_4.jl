using JuMP
using Clp

DEMANDS = [10011.22115007576, 9993.540857825825, 10029.493305561082, 9995.513032624265, 10040.407110819071, 10054.429367942921, 10059.76519849408, 9987.000868933652, 10035.54111237392, 9979.076532648018, 9973.268512810797, 10001.801162849199, 9977.013028384847, 10043.66957251199, 10052.449661342594, 9967.208355572673, 10000.69477091062, 10030.05030028466, 10004.993099108486, 9990.907712391863, 10048.51255532599, 10006.528026036742, 9995.689091324659, 9990.868630720339, 9997.195144776251, 9971.848670139489, 9945.536501292985, 9948.336004602528, 9997.577323187325, 9970.52023558712, 10069.401333593078, 10043.51650796613, 10047.132683479025, 10072.330774070775, 10031.89101682498, 10020.955889705769, 9934.338643331117, 10014.21570856934, 10000.845689612031, 10002.553802750448, 10029.850884936972, 9948.279191163045, 9971.233600233412, 9921.28110096277, 9969.291956593264, 9941.660187262343, 9970.955683172295, 10121.63150429881, 9890.3148430648, 10055.434949187049]

EXCESS = [5262.38201199916, 5860.755189729461, 4984.212894426032, 5363.8531442275635, 4620.34431447503, 3825.9519209367336, 5343.680950738127, 5233.478472018467, 5123.639554039856, 4635.80130213247, 4505.55692176387, 4218.191006304447, 5501.7375350818, 5206.40743566552, 4848.244095467865, 4922.152296817367, 5405.514169790265, 4156.03729448171, 4824.382398257035, 4000.2715617359813, 4390.76908613548, 4842.974771246174, 5220.6774383278635, 4178.847030718337, 5881.9659847155, 5380.195019617506, 4621.415119581128, 6104.345451062469, 5160.047534233344, 5370.740725813598, 4229.219081632929, 5048.335218378297, 4820.895310902216, 5144.298907980797, 4765.881280652281, 4707.799430473926, 4008.493355905563, 4681.96931929508, 6194.13279529005, 5615.828913696583, 4279.739726326251, 4650.89876777662, 4966.17758135978, 5151.236396106044, 5177.558350548357, 5293.24954830797, 4730.71724368456, 5493.7205140204305, 4524.476628100214, 4795.57008939593]
NUC_COST = 300
COAL_COST = 250
T = length(DEMANDS)

m = Model(Clp.Optimizer)
@variable(m, x[1:T] >= 0)
@variable(m, y[1:T] >= 0)
@variable(m, w[1:T] >= 0)
@variable(m, z[1:T] >= 0)
@objective(m, Min, sum(NUC_COST * y[i] + COAL_COST * x[i] for i = 1:T))

for t = 1:T
    @constraint(m, w[t] == sum(x[t:-1:max(1, t-19)]))
    @constraint(m, z[t] == sum(y[t:-1:max(1, t-14)]))
end

@constraint(m, w + z + EXCESS .≥ DEMANDS)
@constraint(m, 0.8 * z - 0.2 * w .≤ 0.2 * EXCESS)

println(m)

optimize!(m)

#status = termination_status(m)

#println("Solution status: ", status)

#println("Objective value: ", objective_value(m))
println("x = ", value.(x))
println("y = ", value.(y))
