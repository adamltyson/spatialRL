function log_like_array=parameter_est(statetrack, actiontrack,alphamax, gammamax,qmax,betamax, environment)
%returns an mxn array of negative log liklihoods for the actions taken at states for
%mxn paramater combinations
initq=0;
beta=2;
factor=10;
gamma=0.8;
alpha=0.1;
%trys each combination of parameters

  for a=1:factor
    h=100*a/factor;
   disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete
   initq=(a*qmax)/factor;
   
for b=1:factor
  beta=(b*betamax)/factor;
parameters=[alpha, beta, gamma, initq];

log_like_array(a,b,1)=prob_for_parameter(statetrack, actiontrack, parameters, environment);

end
%end
end
