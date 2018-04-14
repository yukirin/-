data {
  int<lower=0> N;
  real y[N];
}

transformed data {
  real x[N];
  for (i in 1:N) {
    x[i] = exp(y[i]);
  }
}

parameters {
  real mu;
  real<lower=0> sigma;
}

transformed parameters {
  real<lower=0> sigmasq;
  sigmasq = pow(sigma, 2);
}

model {
  for (i in 1:N) {
    x[i] ~ normal(mu, sigma);
  }
}

generated quantities {
}
