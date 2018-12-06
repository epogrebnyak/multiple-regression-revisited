"""
Explore Base.load_path() behaviour in diffferent situations.

Run this file as:

    julia init_me.jl
    julia --project=@. init_me.jl
    julia --project=. init_me.jl

Try running in a folder that has or does not have Project.toml file.    
"""

MESSAGE = Dict(true => " (exists)", false => " (does not exist)")
exist(path)::Bool = isfile(path) || isdir(path)
printexist(path::String) = println("  ", path, MESSAGE[exist(path)])
printexist(nothing) = println("nothing")
printf2(s,n=8) = print("  " * s * ' '^(n-length(s)))
 
p_ = Base.JLOptions().project
project_option = (p_ != C_NULL) ? unsafe_string(p_) : "option not provided"
println("--project:\n  ", project_option)

println("load_path():")
for path in Base.load_path()
    printexist(path)
end

println("Base.active_project():")
printexist(Base.active_project())
println("Base.current_project():")
printexist(Base.current_project())

println("alias expansion with Base.load_path_expand():")
for alias in ["@.", "@", "@stdlib", "@v1.0"] 
    printf2(alias)
    printexist(Base.load_path_expand(alias))
end

println("Base.DEPOT_PATH collects possible locations for registries:") 
for p in Base.DEPOT_PATH 
    printexist(p)
end