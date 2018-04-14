# ソース・ファイルの場所をウォーキングディレクトリに指定
library(tools)
setwd(file_path_as_absolute(dirname(sys.frame(1)$ofile)))


library(rstan)
scr <- "model.stan"
source("data.R")
data <- list(N=N, n=n)

par <- c("p", "d", "delta_over", "p11", "p10", "p01", "p00", "RR", "OR", "RR_over")

war <- 1000
ite <- 11000
see <- 12345
dig <- 3
cha <- 1
fit <- stan(file=scr, model_name=scr, data=data, pars=par, verbose=F,
            seed=see, chains=cha, warmup=war, iter=ite)

print(fit, pars=par, digits_summary=dig)
plot(fit, pars=par)
traceplot(fit, inc_warmup=T, pars=par)