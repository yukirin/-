# ソース・ファイルの場所をウォーキングディレクトリに指定
library(tools)
setwd(file_path_as_absolute(dirname(sys.frame(1)$ofile)))


library(rstan)
scr <- "model.stan"
source("data.R")
data <- list(N=N, y=y)

par <- c("mu", "sigma", "sigmasq")

war <- 1000
ite <- 20000
see <- 12345
dig <- 3
cha <- 2
fit <- stan(file=scr, model_name=scr, data=data, pars=par, verbose=F,
            seed=see, chains=cha, warmup=war, iter=ite)

print(fit, pars=par, digits_summary=dig)
plot(fit, pars=par)
traceplot(fit, inc_warmup=T, pars=par)