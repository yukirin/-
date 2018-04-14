data {
  int<lower=0> N;
  matrix<lower=0>[N, 2] x;
}

parameters {
  vector[2] mu;
  vector<lower=0>[2] sigma;
  real<lower=-1, upper=1> rho;
}

transformed parameters {
  vector<lower=0>[2] sigmasq;
  matrix[2, 2] Sigma;
  
  sigmasq[1] = pow(sigma[1], 2);
  sigmasq[2] = pow(sigma[2], 2);
  Sigma[1, 1] = sigmasq[1];
  Sigma[2, 2] = sigmasq[2];
  Sigma[1, 2] = sigma[1] * sigma[2] * rho;
  Sigma[2, 1] = sigma[2] * sigma[1] * rho;
}

model {
  for (i in 1:N) {
    x[i] ~ multi_normal(mu, Sigma);
  }
}

generated quantities {
  real delta;
  int<lower=0, upper=1> diff;
  int<lower=0, upper=1> diff_c;
  int<lower=0, upper=1> rho_over;
  int<lower=0, upper=1> rho_over05;
  
  delta = mu[2] - mu[1];
  diff = delta > 0;
  diff_c = delta > 2;
  rho_over = rho > 0;
  rho_over05 = rho > 0.5;
}
