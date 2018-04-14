# ソース・ファイルの場所をウォーキングディレクトリに指定
library(tools)
setwd(file_path_as_absolute(dirname(sys.frame(1)$ofile)))


library(rstan)
scr <- "model.stan"
source("data.R")
data <- list(N=N, x=x)

par <- c("theta", "p3", "P", "mu")

war <- 5000
ite <- 100000
see <- 123
dig <- 3
cha <- 1
fit <- stan(file=scr, model_name=scr, data=data, pars=par, verbose=F,
            seed=see, chains=cha, warmup=war, iter=ite)

print(fit, pars=par, digits_summary=dig)
plot(fit, pars=par)
traceplot(fit, inc_warmup=T, pars=par)
stan_hist(fit, inc_warmup=T, pars="theta")