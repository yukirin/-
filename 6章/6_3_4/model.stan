data {
  int<lower=0> N1;
  int<lower=0> N2;
  vector<lower=0>[N1] x1;
  vector<lower=0>[N2] x2;
}

parameters {
  real mu1;
  real mu2;
  real<lower=0> sigma;
}

transformed parameters {
  real<lower=0> sigmasq;
  
  sigmasq = pow(sigma, 2);
}

model {
  x1 ~ normal(mu1, sigma);
  x2 ~ normal(mu2, sigma);
}

generated quantities {
  real delta;
  int<lower=0, upper=1> diff;
  int<lower=0, upper=1> diff_c;
  
  delta = mu2 - mu1;
  diff = delta > 0;
  diff_c = delta > 1;
}
