using Distributions
using Statistics

a, b = 0, 20
β_0 = 0.5
β = 1
sd_e = 1.1
n1 = 100
s = 50

# TODO: pack this into one tupe
x_dist1 = Uniform(a, b)
y_process1(X) = β_0 .+ X * β
noise_process1(X) = rand(Normal(0, sd_e), size(X, 1), 1)

struct Observation
    X::Array # enforce n*k
    Y::Array #{T,1}
end 

function make_x(n, x_dist)
    return rand(x_dist, n, 1)
end    

function make_observation(X, y_process, noise_process)
    Y = y_process(x) + noise_process(X)
    return Observation(X, Y)
end  

function create_observations(n, x_dist, y_process, noise_process)
    X = make_x(n, x_dist)
    Y = y_process(X) + noise_process(X)
    return Observation(X, Y)
end  

obs1 = create_observations(n1, x_dist1, y_process1, noise_process1)

struct LinearModel
    obs::Observation
    has_intercept::Bool
    beta
end    

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

function add_intercept(X::Array)
    nrows = size(X, 1)
    X0 = ones(nrows, 1)
    return [X0 X]
end    

function add_intercept(obs::Observation)
    return Observation(add_intercept(obs.X), obs.Y)
end  

function evaluate_ols(obs; intercept=false)
    if intercept==true
        obs = add_intercept(obs)
    end    
    beta_hat = ols(obs.X, obs.Y)
    return LinearModel(obs, intercept, beta_hat)
end    

#Y_hat = X * beta_hat 
#RSS = sum((Y_hat - Y) .^ 2)
#TSS = sum((Y .- mean(Y)) .^ 2) # equals var(Y)*n
#R2 = 1-(RSS/TSS) 

yhat(lm::LinearModel) = lm.obs.X * lm.beta 
sum_of_squares(x) = sum(x .^ 2) 
rss(lm::LinearModel) = sum_of_squares(yhat(lm) - lm.obs.Y)
tss(lm::LinearModel) = sum_of_squares(lm.obs.Y .- mean(lm.obs.Y)) # equals var(Y)*n
r2(lm::LinearModel) = 1 - rss(lm)/tss(lm)

lm1 = evaluate_ols(obs1, intercept=true)
println("R-squared: ", round(r2(lm1), digits=4))

# TODO: convert to X arrays
# TODO: import data
# NOT TODO: same in R
# TODO: replicate https://itl.nist.gov/div898/strd/lls/data/LINKS/v-Norris.shtml

# the difference between two ols methods is really small 
@assert all(ols(obs1.X, obs1.Y)-ols_(obs1.X,obs1.Y) .< 1e-10) # was 14
@assert add_intercept(collect(2:4)) == [1 1 1; 2 3 4]'
@assert r2(lm1) > .8
