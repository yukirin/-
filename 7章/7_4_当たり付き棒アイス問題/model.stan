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
	real<lower=0,upper=1>	p3;
	real			P;
	real			mu;
	
	p3 = theta * pow((1 - theta), 2);
	P = theta > inv(36);
	mu = 1 / theta;
}
