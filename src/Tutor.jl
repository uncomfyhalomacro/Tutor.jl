module Tutor

using Test
using Dates

using REPL: REPL
using REPL.TerminalMenus

const EXERCISES = ["001", "002", "003", "004"]

function choose_exercise(exercise)
    menu = RadioMenu(exercise; pagesize=5)
    choice = request("Choose an exercise:", menu)
    if choice != -1
        @info "You chose $(exercise[choice])"
        return exercise[choice]
    end
    @warn "Menu canceled."
    return nothing
end

function start()
    PROJECT_DIR = dirname(Base.current_project(@__DIR__))

    chosen_exercise = choose_exercise(Tutor.EXERCISES)
    while true
        try
            cmdlet = `julia --project="$PROJECT_DIR" "$PROJECT_DIR"/src/exercises/"$chosen_exercise"_hello.jl`
            Base.run(cmdlet)
            @info "You have finally fixed the program! It is happy now thanks to you ❤️ "
        catch e
            @warn "This program needs help!"
            EDITOR = ENV["EDITOR"]
            cmdlet = `$EDITOR "$PROJECT_DIR/src/exercises/001_hello.jl"`
            Base.run(cmdlet)
        end
        println("Choose next exercise? y/n yes/no")
        continue_run = readline()
        if lowercase(continue_run) in ["y", "yes"]
            chosen_exercise = choose_exercise(Tutor.EXERCISES)
        else
            @info "Ending Tutor"
            break
        end
    end
end

end

# End of module
