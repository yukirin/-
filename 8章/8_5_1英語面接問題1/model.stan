// 変量効果モデル
data{
	int<lower=0> S;
	int<lower=0> R;
	vector<lower=0, upper=15>[R] Score[S];
}

parameters{
	real mu;
	real alpha[S];
	real beta[R];
	real<lower=0> tauSubject;
	real<lower=0> tauRater;
	real<lower=0> tauWithin;
}

transformed parameters{
	real<lower=0> sig2subject;
	real<lower=0> sig2rater;
	real<lower=0> sig2within;
	sig2subject = pow(tauSubject,2);
	sig2rater = pow(tauRater,2);
	sig2within = pow(tauWithin,2);
}

model{
	real nu;
	mu ~ normal(0, 1000);
	for(s in 1:S){
		alpha[s] ~ normal(0, tauSubject);
	}
	for(r in 1:R){
		beta[r] ~ normal(0, tauRater);
	}
	for(s in 1:S) {
		for(r in 1:R) {
			nu = mu + alpha[s] + beta[r];
			Score[s,r] ~ normal(nu, tauWithin);
		}
	}
}

generated quantities{
	real<lower=0> ICC21;
	real<lower=0> ICC24;
	real<lower=0> rho5;
	real<lower=0> rho6;
	real nine6;
	ICC21=sig2subject / (sig2subject + sig2rater + sig2within);
	ICC24 = sig2subject / (sig2subject + ((sig2rater + sig2within)/4));
	rho5 = sig2subject / (sig2subject + ((sig2rater + sig2within)/5));
	rho6 = sig2subject / (sig2subject + ((sig2rater + sig2within)/6));
	nine6 = step(rho6 - 0.9);
}
