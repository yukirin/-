data{
	int<lower=0> N;
	matrix[N, 3] x;
}

parameters{
	vector[3] mu;
	vector<lower=0>[3] sigma;
	corr_matrix[3] rho;
}

transformed parameters {
 vector<lower=0>[3] sigmasq;
 matrix[3, 3] Sigma;
 
 for (i in 1:3) {
  sigmasq[i] = pow(sigma[i], 2);
 }
 
 Sigma = diag_matrix(sigma) * rho * diag_matrix(sigma);
}

model{
  for (i in 1:N) {
    x[i] ~ multi_normal(mu, Sigma);
  }
}

generated quantities{
  real rho12;
  real rho23;
  real rho31;
  real delta_rho;
  real delta_rho_over;
  
  rho12 = rho[1, 2];
  rho23 = rho[2, 3];
  rho31 = rho[3, 1];
  delta_rho = rho23 - rho12;
  delta_rho_over = delta_rho > 0;
}
