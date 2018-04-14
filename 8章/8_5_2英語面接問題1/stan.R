# ソース・ファイルの場所をウォーキングディレクトリに指定
library(tools)
setwd(file_path_as_absolute(dirname(sys.frame(1)$ofile)))


library(rstan)
scr <- "model.stan"
source("data.R")
data <- list(S=S, R=R, Score=Score)

par <- c("ICC31", "ICC34", "rho5", "rho6", "nine", "sig2subject", "sig2within")

war <- 15000
ite <- 50000
see <- 12345
dig <- 3
cha <- 1
fit <- stan(file=scr, model_name=scr, data=data, pars=par, verbose=F,
            seed=see, chains=cha, warmup=war, iter=ite)

print(fit, pars=par, digits_summary=dig)
plot(fit, pars=par)
traceplot(fit, inc_warmup=T, pars=par)