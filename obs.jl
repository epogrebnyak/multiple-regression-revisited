function assert_same_rows(X, Y) 
    if size(X,1) == size(Y,1)
        return true
    else 
        throw(DimensionMismatch("X and Y must have same number of rows"))
    end    
end

function assert_vector(Y) 
    if size(Y,2) == 1
        return true
    else 
        # more readable error message than type-checking error message
        throw(DimensionMismatch("Y must be a vector"))                                  
    end
end        

struct Observation
    X::Array 
    Y::Vector
    Observation(X, Y) = (assert_same_rows(X, Y) & assert_vector(Y) 
        ? new(X, Y)
        : throw(ArgumentError)
    )
end