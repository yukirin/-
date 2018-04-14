data {
  int<lower=0> N;
  vector<lower=0>[N] x;
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
  x ~ normal(mu, sigma);
}

generated quantities {
  int<lower=0, upper=1> mu_over7;
  int<lower=0, upper=1> mu_over75;
  
  mu_over7 = mu > 70000;
  mu_over75 = mu > 75000;
}
