data {
  int<lower=0> N;
  int<lower=0> x[N];
}

transformed data{
  int<lower=0> n[N];
  for(i in 1:N)
    n[i] = x[i] - 1;
}

parameters {
	real<lower=0> beta;
}

transformed parameters{
	real<lower=0,upper=1>	theta;
	theta = beta / (beta + 1);
}

model {
	n ~ neg_binomial(1, beta);
}

generated quantities{
	real<lower=0,upper=1>	p4;
	real			mu;
	
	p4 = theta * pow((1 - theta), 3);
	mu = 1 / theta;
}
