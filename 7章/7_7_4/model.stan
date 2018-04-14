data {
  int<lower=0> N;
  int<lower=0> x[N];
}

parameters {
	real<lower=0, upper=1> theta;
}


model {
	x ~ bernoulli(theta);
}

generated quantities {
  real<lower=0, upper=1> p;
  real beta;
  int count;
  
  beta = theta / (1 - theta);
  p = binomial_cdf(4, 4, theta) - binomial_cdf(2, 4, theta);
  count = neg_binomial_rng(2, beta) + 2;
}
