using Distributions
using Statistics

struct Observation
    X::Array # TODO: enforce n*k
    Y::Array # TODO: enforce n*1
end 

# Create function that will return normal observations
function make_normal_sampler(; a, b, β_0, β, sd_e)
    k = size(β, 1)
    make_x_sample(n) = rand(Uniform(a, b), n, k)
    y_process(X) = β_0 .+ X * β
    noise_process(X) = rand(Normal(0, sd_e), size(X, 1), 1)
    function normal_observations(n)
        X = make_x_sample(n)
        Y = y_process(X) + noise_process(X)
        return Observation(X, Y)
    end
    return normal_observations
end     

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

# functions for LinearModel
yhat(lm::LinearModel) = lm.obs.X * lm.beta 
function equation(lm::LinearModel) 
    "must show equation like y=1+0.5*x1"
end        
# TODO = show equation as string
show(lm::LinearModel) = lm.beta

# residual sum of squares
sum_of_squares(x) = sum(x .^ 2) 
rss(lm::LinearModel) = sum_of_squares(yhat(lm) - lm.obs.Y)

# total sum of squares for Y (distances from the mean)
tss(lm::LinearModel) = sum_of_squares(lm.obs.Y .- mean(lm.obs.Y)) # equals var(Y)*n

#R2 = 1-(RSS/TSS) 
r2(lm::LinearModel) = 1 - rss(lm)/tss(lm)

normal_sampler = make_normal_sampler(a=0, b=20, β_0=5, β=[1,2], sd_e=1.1)
obs1 = normal_sampler(100)
lm1 = evaluate_ols(obs1, intercept=true)
println(show(lm1))
# TODO: add below this to show
println("R-squared: ", round(r2(lm1), digits=4))


# TODO: import data
# TODO: replicate https://itl.nist.gov/div898/strd/lls/data/LINKS/v-Norris.shtml

# the difference between two ols methods is really small 
@assert all(ols(obs1.X, obs1.Y)-ols_(obs1.X,obs1.Y) .< 1e-10) # was 14
@assert add_intercept(collect(2:4)) == [1 1 1; 2 3 4]'
@assert r2(lm1) > .8
