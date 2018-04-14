data{
	int<lower=0> N;
	vector[2] xA[N];
	vector[2] xB[N];
}

parameters{
	vector[2] mu[2];
	vector<lower=0>[2] sigma[2];
	vector<lower=-1, upper=1>[2] rho;
}

transformed parameters {
 vector<lower=0>[2] sigmasq[2];
 matrix[2, 2] Sigma[2];
 
 sigmasq[1, 1] = pow(sigma[1, 1], 2);
 sigmasq[1, 2] = pow(sigma[1, 2], 2);
 sigmasq[2, 1] = pow(sigma[2, 1], 2);
 sigmasq[2, 2] = pow(sigma[2, 2], 2);
 
 Sigma[1, 1, 1] = sigmasq[1, 1];
 Sigma[1, 2, 2] = sigmasq[1, 2];
 Sigma[1, 1, 2] = sigma[1, 1] * sigma[1, 2] * rho[1];
 Sigma[1, 2, 1] = sigma[1, 2] * sigma[1, 1] * rho[1];
 
 Sigma[2, 1, 1] = sigmasq[2, 1];
 Sigma[2, 2, 2] = sigmasq[2, 2];
 Sigma[2, 1, 2] = sigma[2, 1] * sigma[2, 2] * rho[2];
 Sigma[2, 2, 1] = sigma[2, 2] * sigma[2, 1] * rho[2];
}

model{
  xA ~ multi_normal(mu[1], Sigma[1]);
  xB ~ multi_normal(mu[2], Sigma[2]);
}

generated quantities{
  real delta_rho;
  real rho_over;
  
  delta_rho = rho[2] - rho[1];
  rho_over = delta_rho > 0;
}
