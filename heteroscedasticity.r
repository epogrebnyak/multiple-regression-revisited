# OLS conditions violations: Heterscedasticity
# Based on:
# https://stats.stackexchange.com/questions/33028/measures-of-residuals-heteroscedasticity

set.seed(17)
n <- 500

make_x = function(){return (rgamma(n, shape=6, scale=1/2))}
make_e = function(x){return (rnorm(length(x), sd=abs(sin(x))))}
b = 2
f = function(x){return (b*x)}
make_y = function(){
  x <- make_x() 
  return (f(x)+make_e(x))  
}

# single run
x <- make_x() 
e <- make_e(x) 
y_true = f(x) 
y <- y_true + e

plot(x,y, main="Observations with heteroscedаsticity")
abline(0, b, col="red")

# estimators


#fit <- lm(y ~ x)
#res <- residuals(fit)
#pred <- predict(fit)



