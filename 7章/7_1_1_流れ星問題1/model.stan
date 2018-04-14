data {
  int<lower=0> N;
  int<lower=0> x[N];
}

parameters {
  real<lower=0> lambda;
}

transformed parameters {
  real<lower=0> lambda_sd;
  lambda_sd = sqrt(lambda);
}

model {
  x ~ poisson(lambda);
}

generated quantities {
  real<lower=0, upper=1> p2;
  
  p2 = (exp(-lambda) * pow(lambda, 2)) / 2;
}
