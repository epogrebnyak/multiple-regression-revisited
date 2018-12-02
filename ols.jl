using Distributions
using Statistics
import LinearModel

function assert_same_rows(X, Y) 
    if size(X,1) == size(Y,1)
        return true
    else 
        throw(ArgumentError("X and Y must have same number of rows"))
    end    
end

function assert_vector(Y) 
    if size(Y,2) == 1
        return true
    else 
        # more readable error message than struct type-checking error message
        throw(ArgumentError("Y must be a vector"))                                  
    end
end        

struct Sample
    X::Array 
    Y::Vector
    Sample(X, Y) = (assert_same_rows(X, Y) & assert_vector(Y) 
        ? new(X, Y)
        : throw(ArgumentError)
    )
end

# Create function that will return normal observations
function make_sample_generator_normal(; a, b, β_0, β, sd_e)
    k = size(β, 1)
    make_x_sample(n) = rand(Uniform(a, b), n, k)
    y_process(X) = β_0 .+ X * β
    noise_process(X) = rand(Normal(0, sd_e), size(X, 1), 1)
    function normal_sample(n)::Sample
        X = make_x_sample(n)                
        Y = vec(y_process(X) + noise_process(X)) # vec reshapes Array{T, 2} to Vector
        return Sample(X, Y)
    end
    return normal_sample
end     

function add_intercept(X::Array)
    nrows = size(X, 1)
    X0 = ones(nrows, 1)
    return [X0 X]
end    

function add_intercept(sample::Sample)
    return Sample(add_intercept(sample.X), sample.Y)
end  


normal_sampler = make_sample_generator_normal(a=0, b=20, β_0=5, β=[1,2], sd_e=1.1)
sam1 = normal_sampler(100)
lm1 = evaluate_ols(sam1, intercept=true)

println(show(lm1))
# TODO: add below this to show
println("R-squared: ", round(r2(lm1), digits=4))


# TODO: import data
# TODO: replicate https://itl.nist.gov/div898/strd/lls/data/LINKS/v-Norris.shtml

# the difference between two ols methods is really small 
#@assert all(ols(obs1.X, obs1.Y)-ols_(obs1.X,obs1.Y) .< 1e-10) # was 14
#@assert add_intercept(collect(2:4)) == [1 1 1; 2 3 4]'
#@assert r2(lm1) > .8
using Test
@test_throws ArgumentError Sample([1, 2, 3], [1, 2])