@echo off 
REM  Let use Julia!
REM  Goto https://julialang.org/downloads/ and do as they say
REM  Try this to display a version, mine in 1.0.2
julia -v
REM  If this step fails, perhaps you are on Windows and julia is not on your PATH
REM  try: http://wallyxie.com/weblog/adding-julia-windows-path-command-prompt/
REM  But hope it works!

REM  Lets say hi! 
REM  (I'm avoiding \" on Windows) 
julia -e "println(ARGS[1])" "Hello, world!"

REM  Make a new julia script file and run it
echo println("Hello, world! Again!") > hello.jl
julia hello.jl

REM Hooray, that makes things done!
