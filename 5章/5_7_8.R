# 基礎からのベイズ統計学第5章 5.7 (8)

# ベータ分布
beta_p = 10.2
beta_q = 5.8

# HMC
sig = 0.05
L = 5

init_theta = 0.1
init_p = 0

# 負の対数事後分布
h <- function(theta) {
  a = -(beta_p - 1) * log(theta)
  b = -(beta_q - 1) * log(1 - theta)
  
  return(a + b)
}

# 負の対数事後分布の微分
h_dash <- function(theta) {
  # ゼロ除算回避
  sigma = 0.000001
  
  a = -(beta_p - 1) / ifelse(theta == 0, sigma, theta)
  b = (beta_q - 1) / ifelse(1 - theta == 0, sigma, 1 - theta)
  return(a + b)
}

# ハミルトニアン
hamiltonian <- function(theta, p) {
  return(h(theta) + (1 / 2) * (p^2))
}

leapfrog <- function(theta, p) {
    p = p - (sig / 2) * h_dash(theta)
    theta = theta + sig * p
    p = p - (sig / 2) * h_dash(theta)
  
  return(list(theta, p))
}

thetas = c(init_theta)
ps = c(init_p)
h_thetas = c(h(init_theta))
hamils = c(hamiltonian(init_theta, init_p))
  
for (i in 1:L) {
  moved = leapfrog(tail(thetas, 1), tail(ps, 1))
  thetas = append(thetas, moved[[1]])
  ps = append(ps, moved[[2]])
  h_thetas = append(h_thetas, h(moved[[1]]))
  hamils = append(hamils, hamiltonian(moved[[1]], moved[[2]]))
}
  
for (i in 0:L + 1) {
  print(sprintf("p=%f θ=%f h(θ)=%f H(θ,p)=%f", ps[i], thetas[i], h_thetas[i], hamils[i]))
}
