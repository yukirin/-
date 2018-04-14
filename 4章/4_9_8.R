# 基礎からのベイズ統計学 4-9 (8)

# set.seed(1234)
qme <- 0
qsd <- sqrt(0.001)

n <- 10^5
burn_in <- 10^3
accept <- 0

samples <- numeric(n)
theta <- rnorm(1, mean=qme, sd=qsd)
samples[1] = theta

for (i in 2:n + burn_in) {
  alpha <- theta + rnorm(1, mean=qme, sd=qsd)
  
  r <- dgamma(alpha, shape=11, rate=13) / dgamma(theta, shape=11, rate=13)
  
  if (runif(1) < r) {
    theta <- alpha
    accept <- accept + 1
  } 
  samples[i] <- theta
}

print(mean(tail(samples, n=n)))
# 受容率
print(accept / (n + burn_in))
# trace line
plot(1:n, tail(samples, n=n), type="l")