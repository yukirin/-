data {
  int<lower=0> N;
  vector<lower=0>[N] x;
}

parameters {
  real<lower=0> lambda;
}

transformed parameters {
  real<lower=0> mu;
  mu = 1 / lambda;
}

model {
  x ~ exponential(lambda);
}

generated quantities {
  real<lower=0, upper=1> p;
  int<lower=0, upper=1> under_50;
  
  p = 1 - exp(-100 * lambda);
  under_50 = p > 0.5;
}
