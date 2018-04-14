# 基礎からのベイズ統計学第5章 5.7 (10)

# ベータ分布
beta_p <- 10.2
beta_q <- 5.8

# HMC
sig <- 0.01
L <- 100
Time <- 1000
burnin <- 100

init_theta <- 0.5

# 負の対数事後分布
h <- function(theta) {
  a <- -(beta_p - 1) * log(theta)
  b <- -(beta_q - 1) * log(1 - theta)
  
  return(a + b)
}

# 負の対数事後分布の微分
h_dash <- function(theta) {
  # ゼロ除算回避
  sigma = 0
  
  a <- -(beta_p - 1) / ifelse(theta == 0, sigma, theta)
  b <- (beta_q - 1) / ifelse(1 - theta == 0, sigma, 1 - theta)
  return(a + b)
}

# ハミルトニアン
H <- function(theta, p) {
  return(h(theta) + (1 / 2) * (p^2))
}

# リープ・フロッグ法
leapfrog <- function(theta, p) {
  p <- p - (sig / 2) * h_dash(theta)
  theta = theta + sig * p
  p <- p - (sig / 2) * h_dash(theta)
  
  return(c(theta, p))
}

pred <- function(theta, p) {
  moved <- c(theta, p)
  for (i in 1:L) {
    moved <- leapfrog(moved[1], moved[2])
  }
  return(moved)
}

HMC <- function() {
  thetas <- c(init_theta)
  for (i in 1:Time) {
    random_p <- rnorm(1, 0, 1)[1]
    candidate <- pred(tail(thetas, 1), random_p)
    
    r <- exp(H(tail(thetas, 1), random_p) - H(candidate[1], candidate[2]))
    
    next_theta <- ifelse(runif(1) < r, candidate[1], tail(thetas, 1))
    thetas <- append(thetas, next_theta)
  }
  return(thetas)
}

result <- HMC()
print(mean(tail(result, Time - burnin)))
