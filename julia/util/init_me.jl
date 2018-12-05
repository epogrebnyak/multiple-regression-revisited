""" Explore Base.load_path()  behaviour in diffferent situations.

Run this file as:

    julia init_me.jl
    julia --project=@. init_me.jl
    julia --project=. init_me.jl

Try running in a folder that has or does not have a Project.toml file.    
"""

MESSAGE = Dict(true => "Exists         ", false => "Does not exist ")
exist(path)::Bool = isfile(path) || isdir(path)
printexist(path::String) = println(MESSAGE[exist(path)], path)
printexist(nothing) = println("nothing")
 
println("--project: ")
p_ = Base.JLOptions().project
project_option = (p_ != C_NULL) ? unsafe_string(p_) : "option not provided"
println(project_option)

println()
println("load_path():")
for path in Base.load_path()
    printexist(path)
end

println()
println("Base.active_project():")
printexist(Base.active_project())

println()
println("Base.current_project():")
printexist(Base.current_project())


# echo 
# echo lets try activate another environment
# julia -e"import Pkg; Pkg.activate(ARGS[1]);println(Base.active_project())" "."
# julia -e"println(isfile(Base.active_project()))" --project=.

# println("Base.DEPOT_PATH collects possible locations for registries") 
# println("Some locations exist (true), some may not(false)") 
# for p in Base.DEPOT_PATH println(message[isdir(p)], ": $p") end





# julia -e"for path in Base.load_path() println(path) end" --project=.

# REM active directory or nothing

# julia -e"display(Base.load_path_expand(ARGS[1]))" "@"
# julia -e"import Pkg;Pkg.activate(ARGS[2]); display(Base.load_path_expand(ARGS[1]))" "@" "."
# REM home directory (if it has a project)
# julia -e"display(Base.load_path_expand(ARGS[1]))" "@."
# REM standard library directory
# julia -e"display(Base.load_path_expand(ARGS[1]))" "@stdlib"
# REM specific version directory
# julia -e"display(Base.load_path_expand(ARGS[1]))" "@1.0.2"

# REM back to top directory
# cd ..



