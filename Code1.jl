#module Code1

## Pkg.add("Distributions") # If you don't already have it installed.
using Distributions
using Statistics

struct Bounds
    min
    max 
end

struct LinearCoefficients
    intercept
    slopes
end    

# Example from https://github.com/giob1994/Alistair.jl
n = 100
b = Bounds(0, 20)
β0 = 0.7
β = [0.45]
sd_e = 1 

X1 = rand(Uniform(xmin, xmax), n, 1)
X0 = ones(n, 1)
X = [X0 X1]
e = rand(Normal(0, sd_e), n, 1)
Y = X * β + e


function uniform_x(k, b::Bounds, n=n::Int)
   return rand(Uniform(b.min, b.max), n, k)
end


function nrows(X::Array):
    return size(X)[1]


function make_ones_column(X):
    nrows = size(X)[1]
    return ones(nrows, 1)
end

function add_intercept(X::Array)
    X0 = make_ones_column(X)
    return [X0 X]
end    

function make_e(;mean=0, sd=1, dist=Normal, n=n)
    return rand(dist(mean, sd), n, 1)
end

function make_x(c::Coefficients, b::Bounds, n::Int):
    k = nrows(c.slopes)
    X = uniform_x(k, b, n)
    if c.intercept != 0:
        X = add_intercept(X)       
    end    
    return X

function make_beta(c::Coefficients):
    if c.intercept == 0:
        return c.slopes
    else:
        return [c.intercept c.slopes]
    end
end        

function make_y(c::Coefficients, X):
    β = make_beta(c)
    return X * β

n = 100
x_bounds = Bounds(0, 20)
lin_coef = Coefficients(0.7, [0.45])

function rnorm(mean=0, sd=1)
    rand(Normal(mean, sd))
end

function make_homoscedastic_normal_distrubance(X; mean=0, sd=1)
    return [rnorm(mean, sd) for i in X[:,1]]
end    
    

# x generator
# x*b
function make_observations_normal(N=100)
    X = make_x(lin_coef, x_bounds, n)
    e = make_homoscedastic_normal_distrubance(X, sd=1)
    Y = make_y(lin_coef, X) + e
    return 





   

# OLS estimation using \
# https://github.com/giob1994/Alistair.jl/blob/3a11c19150169695581b46e4d1895f0641a4c29d/src/linregress.jl#L38-L41
function ols(X, Y)
    # Ax = B
    # x = B \ A 
    # https://github.com/JuliaLang/julia/blob/d789231e9985537686052db9b2314c0d51656308/stdlib/LinearAlgebra/src/generic.jl#L827-L855
    return (X' * X) \ (X' * Y)
end 

# OLS estimation using inv()
# inv() is a more computationally-intensive procedure than \ operator
# https://github.com/mcreel/Econometrics/blob/b29cffa8ce7f845fa73788522f9c7753d40684f4/Examples/OLS/OlsFit.jl#L13-L14
function ols_(X, Y)
    return inv(X'*X)*X'*Y
end

# the difference between two methods is really small 
@assert all(ols(X, Y)-ols_(X,Y) .< 1e-10) # was 14


beta_hat = ols(X, Y)
Y_hat = X * beta_hat 
RSS = sum((Y_hat - Y) .^ 2)
TSS = sum((Y .- mean(Y)) .^ 2) # equals var(Y)*n
R2 = 1-(RSS/TSS)  
println("R-squared", round(R2, digits=4))

#TODO:
#- https://docs.julialang.org/en/v1/manual/workflow-tips/index.html#REPL-based-workflow-1
# filled an issue: https://github.com/JuliaLang/julia/issues/30190

# DONE: 
#-  "\U003B2\U00302" does not make a beta-hat on windows
#   see https://github.com/JuliaLang/julia/issues/30175

struct Observation
    X # enforce n*k
    Y # enforce n*1
end   

function add_intercept(X::Array)
    nrows = size(X)[1]
    X0 = ones(nrows, 1)
    return [X0 X]
end    

@assert add_intercept(collect(1:3)) == [1 1 1; 1 2 3]'

function add_intercept(obs::Observation)
    X_ = add_intercept(obs.X)
    return Observation(X_, obs.Y)
end    

  

function model(observation, add_intercept=true)
    return LinearModel(observation, add_intercept, beta_hat=nothing)
end    
# functions add add_intercept
#X1 = rand(Uniform(xmin, xmax), n, 1)
#X0 = ones(n, 1)
#X = [X0 X1]


mutable struct LinearModel
    data::Observation
    X 
    beta_hat # n*(k+1)
end

function evaluate_ols(X, Y, add_intercept=true)
    obs = Observation(X, Y)

    # if add_intercept is True, modify X before evaluation 
    beta_hat = ols(X, Y)
    return LinearModel(obs, add_intercept, beta_hat)
end    

lm = evaluate_ols(X, Y)    

#    
# make predicted values based on linear model
# 

#function replicate(func, n, k):
#    retrun [func() for i in 1:n, j in 1:k]    

#function make_x(n, β::Vector, dist)
#    k = length(β)
#    return replicate(rand(dist), n, k)
#end

function nrows(X::Array)
    return size(X)[1]
end    

function make_beta(β, β_0=0)
    if β_0 == 0
        return β
    else
        return [β_0 β]
    end
end        
