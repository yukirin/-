data {
  int<lower=0> N;
  vector<lower=0>[N] x;
}

parameters {
  real<lower=0> sigma;
}

transformed parameters {
  real<lower=0> sigmasq;
  sigmasq = pow(sigma, 2);
}

model {
  x ~ normal(130, sigma);
}

generated quantities {
  int<lower=0, upper=1> under_1;
  int<lower=0, upper=1> under_15;
  
  under_1 = sigmasq < 1;
  under_15 = sigmasq < 1.5;
}
