
State = Int64
Action = Int64
DPTable = Array{Dict{State, Float64}, 1}

StatesAvailable = Dict(
    5 => [0],
    4 => [1, 2, 3, 4],
    3 => [1, 2, 3, 4, 5],
    2 => [1, 2, 3, 4, 5, 6],
    1 => [1, 2, 3, 4, 5, 6, 7]
)

ActionsAvailble = Dict(
    (1, 1) => [2, 3, 4],
    (2, 2) => [5],
    (2, 3) => [5, 6],
    (2, 4) => [5, 6],
    (3, 5) => [7],
    (3, 6) => [7],
    (4, 7) => [7]
)

Transitions = Dict(
    (1, 2) => (2, 7),
    (1, 3) => (3, 8),
    (1, 4) => (4, 5),
    (2, 5) => (5, 12),
    (3, 5) => (5, 8),
    (3, 6) => (6, 9),
    (4, 5) => (5, 7),
    (4, 6) => (6, 13),
    (5, 7) => (7, 9),
    (6, 7) => (7, 6)
#    (7, 7) => (7, 0)
)

EndState = Dict(7 => 0.0)

function state_func(state) 
    return StatesAvailable[state]
end 

function actions_func(stage, state)
    lo = 1
    hi = max(state - 4, 0)
    if hi < lo 
        lo, hi = hi, lo 
    end
    return collect(lo:hi)
end

function transitions(state, action)
    return Transitions[(state, action)]
end

function is_better(minimize::Bool, x::Float64, y::Float64)
    if minimize
        return x < y 
    end
    return x > y 
    
end

function compute_solution_by_br(current_stage::Int64, 
        minimize::Bool,
        table::DPTable, 
        state_func, 
        actions_func,
        transition)
    if(current_stage == 0)
        return reverse(table)
    end
    factor = 1
    
    if !minimize
        factor = -1
    end
    


    states = state_func(current_stage)
    table_next = table[end]
    table_curr = Dict{State, Float64}()
    for state ∈ states 
        table_curr[state] = factor * Inf
        actions = actions_func(current_stage, state)
        for action ∈ actions
            transition = transitions(state, action)
            new_state = transition[1]
            val = transition[2]
            if new_state ∈ keys(table_next)
                value_of_action = table_next[new_state] + val
                if is_better(minimize, value_of_action, table_curr[state])
                    table_curr[state] = value_of_action
                end
            end
        end
    end
    push!(table, table_curr)
    return compute_solution_by_br(current_stage - 1, minimize, 
        table, state_func, actions_func, transition)
end

table = [Dict(7 => 0.0)]
compute_solution_by_br(3, true, table, state_func, actions_func, transitions)