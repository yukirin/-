data {
  int<lower=0> N;
  vector<lower=0>[N] y;
}

transformed data {
  vector[N] x;
  for (i in 1:N) {
    x[i] = exp(y[i]);
  }
}

parameters {
  real mu;
  real<lower=0> sigma;
}

transformed parameters {
}

model {
  for (i in 1:N) {
    x[i] ~ normal(mu, sigma);
  }
}

generated quantities {
  real<lower=0> sigmasq;
  sigmasq = pow(sigma, 2);
}
