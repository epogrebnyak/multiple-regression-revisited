rm(list=ls())
set.seed(34)

# sample size
N = 100


# explanatory variables
make_x = function(n=N, xmin=0, xmax=100){
  return (runif(n, xmin, xmax))
}

# define true model
b0 = 15
b1 = 0.5
f = function(x){
   return (b0 + b1 * x)
}

# generate disturbances
sd_e = 4
make_epsilon = function(n=N, mean=0, sd=sd_e){
  return (rnorm(n, mean, sd)) 
}

# make data generating process
dgp = function(){
  x = make_x()
  e = make_epsilon()
  return (data.frame(x=x,y=f(x)+e))
}

# estime by ols once and show results
df = dgp()
plot(df$x,df$y, xlab = "x", ylab="y")
abline(a=b0,b=b1, col="green", main="Observations and true model")


# TODO: make plot for distrubance term
# plot(make_x(), make_epsilon())


lm1 <- lm(y~x, data = df)
summary(lm1)


extract_b0  = function(lm_){
  return (coef(lm)[1])
}

extract_b1  = function(lm_){
  return (coef(lm)[2])
}

# repeat estimation 
get_b1 = function(){extract_b1(lm(y~x, data = dgp()))}

n_experiments = 1000
b1_list = replicate(n_experiments, get_b1())


# plot estimator desities 
b1_avg = mean(b1_list)
b1_sd = sd(b1_list)
h = hist(b1_list, breaks=40, freq=FALSE, 
         main=paste("Distribution of b1 on", n_experiments,"experiments"),
         sub=paste("True value:", b1, "    ",
                   "Mean: ", round(b1_avg,4), "    ",
                   "SD: ", round(b1_sd,4)),
         xlab="b1")
curve(dnorm(x, mean=b1_avg, sd=b1_sd),
      add=TRUE, col="darkblue", lwd=2) 
abline(v=b1, col ="green")
abline(v=b1_avg, col ="red")

