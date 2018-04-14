# 基礎からのベイズ統計学 4-9 (2)
set.seed(1234)

for (i in 1:6) {
  x <- numeric(10^i)
  for (index in 1:10^i) {
    x[index] <- (runif(1)^2 + runif(1)^2 < 1) * 4
  }
  print(mean(x))
}
