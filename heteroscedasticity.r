# OLS conditions violations 
# Heterscedasticity
# source:
# https://stats.stackexchange.com/questions/33028/measures-of-residuals-heteroscedasticity

set.seed(17)
n <- 500
fit <- lm(y ~ x)
res <- residuals(fit)
pred <- predict(fit)

x <- rgamma(n, shape=6, scale=1/2)
e <- rnorm(length(x), sd=abs(sin(x)))
y_true = 2*x 
y <- y_true + e

plot(x,y)
plot(x,y_true)
plot(x,e)