data {
  int<lower=0> N;
  vector<lower=0>[N] x;
}

parameters {
  real<lower=0> mu;
  real<lower=0> sigma;
}


model {
  x ~ lognormal(mu, sigma);
}

generated quantities {
  real<lower=0> border;
  int<lower=0, upper=1> over_5;
  
  border = exp(mu);
  over_5 = 500 > border;
}
