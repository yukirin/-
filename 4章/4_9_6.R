# 基礎からのベイズ統計学 4-9 (6)

set.seed(1234)
qme <- 1.0
qsd <- sqrt(0.5)

n <- 10^5
burn_in <-10^3

samples <- numeric(n)
theta <- rnorm(1, mean=qme, sd=qsd)
samples[1] = theta
  
for (i in 2:n + burn_in) {
  alpha <- rnorm(1, mean=qme, sd=qsd)
  
  r <- (dnorm(theta, mean=qme, sd=qsd) * dgamma(alpha, shape=11, rate=13)) /
        (dnorm(alpha, mean=qme, sd=qsd) * dgamma(theta, shape=11, rate=13))
  
 
  if (runif(1) < r) {
    theta <- alpha
  } 
  samples[i] <- theta
}
  
print(mean(tail(samples, n=n)))