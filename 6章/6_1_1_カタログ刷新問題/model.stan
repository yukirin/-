data {
  int<lower=0> N;
  real x[N];
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
  for (i in 1:N) {
    x[i] ~ normal(mu, sigma);
  }
}

generated quantities {
  int<lower=0, upper=1> u_2500;
  int<lower=0, upper=1> u_3000;
  real es;
  
  u_2500 = mu > 2500;
  u_3000 = mu > 3000;
  es = ((mu - 2500) / sigma) > 0.8;
}
