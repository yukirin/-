data {
  int<lower=0> N;
  real x[N];
}

parameters {
  real<lower=0> sigma;
}

transformed parameters {
  real<lower=0> sigma2;
  sigma2 = pow(sigma, 2);
}

model {
  for (i in 1:N) {
    x[i] ~ normal(145.0, sigma);
  }
}

generated quantities {
  int<lower=0, upper=1> u_10;
  int<lower=0, upper=1> u_15;
  
  u_10 = sigma2 > 0.1;
  u_15 = sigma2 > 0.15;
}
