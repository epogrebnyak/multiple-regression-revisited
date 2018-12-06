"""
Sample(X,Y)

Sample data type holds X array of size n*k (known as explanatory variables, 
independent variables, or features) and Y n*1 sized vector (response or 
dependent variable) for observed data.    
"""
struct Sample
    X::Array 
    Y::Vector
    function Sample(X, Y)
        td(message:: String) = throw(DimensionMismatch(message)) 
        size(X,1) == size(Y,1) || td("X and Y must have same number of rows")
        size(Y,2) == 1 || td("Y must be a vector: $Y")   
        new(X, Y)
    end    
end

using Test
x = [[1,2,3] [4,5,6]]
y = [1,2,3]
sam = Sample(x, y)
@test sam.X == [[1,2,3] [4,5,6]]
@test sam.Y == [1,2,3]
@test_throws DimensionMismatch Sample([1,2], [1,2,3])
@test_throws DimensionMismatch Sample(y, x)