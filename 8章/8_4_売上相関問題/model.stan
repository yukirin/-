data{
	int<lower=0> Ny;
	int<lower=0> Nx;
	vector[2] y[Ny];
	vector[Nx] x;
}

parameters{
	vector[2] mu_y;
	vector<lower=0>[2] sigma_y;
	real<lower=-1, upper=1> rho_y;
	
	vector[2] mu;
	vector<lower=0>[2] sigma;
	real<lower=-1, upper=1> rho;
}

transformed parameters {
  vector<lower=0>[2] sigmasq_y;
  matrix[2, 2] Sigma;
 
  vector<lower=0>[2] sigmasq;
  matrix[2, 2] Sigma2;
 
  sigmasq_y[1] = pow(sigma_y[1], 2);
  sigmasq_y[2] = pow(sigma_y[2], 2);
 
  Sigma[1, 1] = sigmasq_y[1];
  Sigma[2, 2] = sigmasq_y[2];
  Sigma[1, 2] = sigma_y[1] * sigma_y[2] * rho_y;
  Sigma[2, 1] = sigma_y[2] * sigma_y[1] * rho_y;
 
  sigmasq[1] = pow(sigma[1], 2);
  sigmasq[2] = pow(sigma[2], 2);
  Sigma2[1, 1] = sigmasq[1];
  Sigma2[2, 2] = sigmasq[2];
  Sigma2[1, 2] = sigma[1] * sigma[2] * rho;
  Sigma2[2, 1] = sigma[2] * sigma[1] * rho;
}

model{
  // 8.4.1
  y ~ multi_normal(mu_y, Sigma);
  
  // 8.4.2
  y ~ multi_normal(mu, Sigma2);
  x ~ normal(mu[1], sigma[1]);
}

generated quantities{
}
