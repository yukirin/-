data {
  int<lower=0> N;
  int<lower=0> x[N];
}

parameters {
  real<lower=0> lambda;
}

model {
  x ~ poisson(lambda);
  
}

generated quantities {
  real<lower=0.000001> pred; 
	pred = gamma_rng(3,lambda) * 5; 
}
