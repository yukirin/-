// 混合効果モデル
data{
	int<lower=0> S;
	int<lower=0> R;
	vector<lower=0, upper=15>[R] Score[S];
}
transformed data{
	int<lower=0> Rm1;
	Rm1 = R-1;
}
parameters{
	real mu;
	real alpha[S];
	real beta_m1[Rm1];
	real<lower=0> tauSubject;
	real<lower=0> tauWithin;
}
transformed parameters{
	real beta[R];
	real<lower=0> sig2subject;
	real<lower=0> sig2within;
	sig2subject = pow(tauSubject,2);
	sig2within = pow(tauWithin,2);
	for (r in 1:Rm1) {
		beta[r] = beta_m1[r];
	}
	beta[R] = -sum(beta_m1);
}
model{
	real nu;
	mu ~ normal(0, 1000);
	for(s in 1:S){
		alpha[s] ~ normal(0, tauSubject);
	}
	for(s in 1:S) {
		for(r in 1:R) {
			nu = mu + alpha[s] + beta[r];
			Score[s,r] ~ normal(nu, tauWithin);
		}
	}
}
generated quantities{
	real<lower=0> ICC31;
	real<lower=0> ICC34;
	real<lower=0> rho5;
	real<lower=0> rho6;
	real nine;
	ICC31 = sig2subject / (sig2subject + sig2within); 
	ICC34 = sig2subject / (sig2subject + (sig2within/R));
	rho5 = sig2subject / (sig2subject + (sig2within/5));
	rho6 = sig2subject / (sig2subject + (sig2within/6));
	nine = step(rho5 - 0.9);
}
