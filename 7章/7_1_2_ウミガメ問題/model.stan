data {
  int<lower=0> N;
  int<lower=0> x1[N];
  int<lower=0> x2[N];
}

parameters {
  real<lower=0> lambda1;
  real<lower=0> lambda2;
}


model {
  x1 ~ poisson(lambda1);
  x2 ~ poisson(lambda2);
}

generated quantities {
  real delta;
  int<lower=0, upper=1> diff_0;
  
  delta = lambda2 - lambda1;
  diff_0 = delta > 0;
}
