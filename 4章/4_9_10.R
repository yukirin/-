# 基礎からのベイズ統計学 4-9 (10)

# set.seed(1234)
qme <- 0
qsd <- sqrt(0.1)

n <- 10^5
burn_in <- 10^3
accept <- 0

samples <- numeric(n)
theta <- rnorm(1, mean=qme, sd=qsd)
samples[1] = theta

for (i in 2:n + burn_in) {
  alpha <- theta + rnorm(1, mean=qme, sd=qsd)
  
  r <- dbeta(alpha, shape1=10.2, shape2=5.8) / dbeta(theta, shape1=10.2, shape2=5.8)
  
  if (runif(1) < r) {
    theta <- alpha
    accept <- accept + 1
  } 
  samples[i] <- theta
}

win_rate = mean(tail(samples, n=n))
print(win_rate)
# 受容率
print(accept / (n + burn_in))
# trace line
plot(1:n, tail(samples, n=n), type="l")

# 5試合行って3勝2敗する確率(事後予測分布)
g <- function(theta) {
  return(dbinom(3, 5, theta))
}

data <- g(tail(samples, n=n))
print(mean(data))
print(sd(data))