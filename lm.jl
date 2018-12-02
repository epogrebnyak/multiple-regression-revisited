struct LinearModel
    observed::Sample
    has_intercept::Bool
    beta
end    

# OLS estimation using (\)
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

function add_intercept(sample::Sample)
    return Sample(add_intercept(sample.X), sample.Y)
end  

function evaluate_ols(sample::Sample; intercept::Bool=false)
    if intercept==true
        obs = add_intercept(sample)
    end    
    beta_hat = ols(sample.X, sample.Y)
    return LinearModel(obs, intercept, beta_hat)
end    

# functions for LinearModel

"""Return fitted dependent variable Y."""
function yhat(lm::LinearModel)
    if im.intercept == true
        f = add_intercept
    else 
        f = identity
    end    
    return f(lm.observed.X) * lm.beta 
end    

# FIXME    
function equation(lm::LinearModel) 
    "must show equation like y=1+0.5*x1"
end        

# TODO = show equation as string
show(lm::LinearModel) = lm.beta

# residual sum of squares
# TODO: add real output type
sum_of_squares(x) = sum(x .^ 2) 
rss(lm::LinearModel) = sum_of_squares(yhat(lm) - lm.observed.Y)

# total sum of squares for Y (distances from the mean)
tss(lm::LinearModel) = sum_of_squares(lm.observed.Y .- mean(lm.observed.Y)) # equals var(Y)*n

#R2 = 1-(RSS/TSS) 
r2(lm::LinearModel) = 1 - rss(lm)/tss(lm)
