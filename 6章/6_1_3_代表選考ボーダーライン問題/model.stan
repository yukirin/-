data {
  int<lower=0> N;
  vector<lower=0>[N] x;
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
  real<lower=0> quantile_3rd;
  real<lower=0, upper=1> prob_over;
  
  quantile_3rd = mu + 0.675 * sigma;
  prob_over = 1 - normal_cdf(quantile_3rd, 805, 10);
}
