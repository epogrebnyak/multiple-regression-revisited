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
