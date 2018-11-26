# OLS conditions violations: Heterscedasticity
# Based on:
# https://stats.stackexchange.com/questions/33028/measures-of-residuals-heteroscedasticity
# See also:
# https://stats.stackexchange.com/questions/258485/simulate-linear-regression-with-heteroscedasticity

set.seed(17)
n <- 500

make_x = function(){return (rgamma(n, shape=6, scale=1/2))}
make_e = function(x){return (rnorm(length(x), sd=abs(sin(x))))}
b = 2
f = function(x){return (b*x)}
dgp = function(){
  x <- make_x() 
  y = f(x)+make_e(x)
  return (data.frame(x=x,y=y))
}

# single run
x <- make_x() 
e <- make_e(x) 
y_true = f(x) 
y <- y_true + e
fit <- lm(y ~ x + 0)


# regression 
png("C:/Users/Евгений/Documents/GitHub/multiple-regression-revisited/hsc1.png")
plot(x,y, main="Observations with heteroscedаsticity")
abline(0, b, col="green")
abline(fit, col="red")
dev.off()


# repeat estimation 
extract_b0  = function(lm_){return (coef(lm_)[1])}
get_b = function(){coef(lm(y~x+0, data = dgp()))}
n_experiments = 1000
bs = replicate(n_experiments, get_b())


# plot estimator desities 

png("C:/Users/Евгений/Documents/GitHub/multiple-regression-revisited/hsc2.png")

b_avg = mean(bs)
b_sd = sd(bs)
h = hist(bs, breaks=40, freq=FALSE, 
         main=paste("Distribution of b on", n_experiments,"experiments"),
         sub=paste("True value:", b, "    ",
                   "Mean: ", round(b_avg,4), "    ",
                   "SD: ", round(b_sd,4)),
         xlab="b",
         col="lightblue")
# curve(dnorm(x, mean=b_avg, sd=b_sd), add=TRUE, col="darkblue", lwd=2) 
lines(density(bs), col="darkblue", lwd=2) 
abline(v=b, col ="green")
abline(v=b_avg, col ="red")


# from https://stackoverflow.com/questions/6973579/plotting-probability-density-mass-function-of-dataset-in-r
# hist(energy,probability=TRUE)
# lines(density(bs), col="darkblue", lwd=2) 

dev.off()

