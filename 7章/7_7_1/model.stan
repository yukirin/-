data {
  int<lower=0> N;
  int<lower=0> xn[N];
  int<lower=0> xm[N];
}

parameters {
  real<lower=0> lambdan;
  real<lower=0> lambdam;
}


model {
  xn ~ poisson(lambdan);
  xm ~ poisson(lambdam);
}

generated quantities {
  real delta;
  int<lower=0, upper=1> diff_0;
  
  delta = lambdan - lambdam;
  diff_0 = delta > 0;
}
