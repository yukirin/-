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
  real<lower=0> div_90;
  real<lower=0, upper=1> prob;
  
  div_90 = mu + 1.282 * sigma;
  prob = 1 - normal_cdf(div_90, 87, 5);
}
