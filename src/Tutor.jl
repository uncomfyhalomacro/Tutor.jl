module Tutor

using Test
using Dates

function run()
    PROJECT_DIR = dirname(Base.current_project(@__DIR__))

    while true
        try
            cmdlet = `julia --project="$PROJECT_DIR" "$PROJECT_DIR"/src/exercises/001_hello.jl`
            Base.run(cmdlet)
            @info "You have finally fixed the program! It is happy now thanks to you ❤️ "
            break
        catch e
            @warn "This program needs help!"
            EDITOR = ENV["EDITOR"]
            cmdlet = `$EDITOR "$PROJECT_DIR/src/exercises/001_hello.jl"`
            Base.run(cmdlet)
        end
    end
end

end

# End of module
