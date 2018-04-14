data{
	int<lower=0> Ny;
	vector[2] y[Ny];
}

parameters{
	vector[2] mu_y;
	vector<lower=0>[2] sigma_y;
	real<lower=-1, upper=1> rho_y;
}

transformed parameters {
  vector<lower=0>[2] sigmasq_y;
  matrix[2, 2] Sigma;
 
  sigmasq_y[1] = pow(sigma_y[1], 2);
  sigmasq_y[2] = pow(sigma_y[2], 2);
 
  Sigma[1, 1] = sigmasq_y[1];
  Sigma[2, 2] = sigmasq_y[2];
  Sigma[1, 2] = sigma_y[1] * sigma_y[2] * rho_y;
  Sigma[2, 1] = sigma_y[2] * sigma_y[1] * rho_y;
}

model{
  y ~ multi_normal(mu_y, Sigma);
}

generated quantities{
}
