%estimate_q_pred_error.m


%finds average sequence of q values and prediction errors based on
%parameter likelihoods

% % % 1. Grid up the 4 (or 5?) dimensional space of parameter values. You should end up with approx. order 1M grid points I guess, but you can try: the more the better (ie more accurate estimates) but slower. I will index grid points by i.
% % % 2. Define a prior over this space. You can start with a uniform prior. Let's denote the log of the prior probability for grid point i Q_i. (So in the uniform case, if there are G grid points than Q_i = -log N.

fac=30;
prior_ll_param=log((1/fac^4))*ones(fac, fac, fac, fac); % log likelihood of parameter combinations

minparam=[0 0 0 0];
maxparam=[1 20 1 5];

for index1=1:fac;  
alphas(index1)=((index1*maxparam(1))/fac)+minparam(1);
betas(index1)=((index1*maxparam(2))/fac)+minparam(2);
gammas(index1)=((index1*maxparam(3))/fac)+minparam(3);
qs(index1)=((index1*maxparam(4))/fac)+minparam(4);
end
 

% % 3. Given a particular S-A sequence, for each grid point (corresponding to a particular parameter combination) i, compute
% % A) the predicted Q-value or prediction error in all trials, denoted as X_{t,i}, where t indexes trials
% % B) the loglikelihood of the parameter combination for the given S-A sequence, denoted as ll_pram_combin_i.

 for a=1:fac
      h=100*a/fac;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete
     alpha=alphas(a);
     for b=1:fac
         beta=betas(b);
         for g=1:fac
             gamma=gammas(g);
             for q=1:fac
                 Q0=qs(q);
[~,X_pred_error(a, b,g,q, :),X_qaction(a, b,g,q, :)]=estimate_qvalues([alpha beta gamma Q0], statetrack, actiontrack, environment); %find series of estimated pred errors and q actions for each parameter combination
ll_param_combin(a, b, g, q)=(minimise_function([alpha beta gamma Q0])*(-1));  
             end
         end
     end
 end
 
 %%%%% 4. Compute the unnormalised logposterior over parameter combinations: P_i = Q_i + L_i, and the normalisation factor for it: Z =  sum_j exp(Q_j + L_j)
 
 logposterior=prior_ll_param+ll_param_combin;
 
 Z_1=exp(logposterior);    
 norm_factor=sum(sum(sum(sum(Z_1))));
 
 
 %%%%  . For each trial, average the predicted Q-value or prediction error over all parameter combinations (grid points in the parameter space) with the averaging weights being the posterior probabilities:
 Z=1/norm_factor;
%  posteriorprob=exp(logposterior);
 
 weightedprob(a, b, g, q, :)=(X_pred_error(a, b, g, q, :)) *exp(logposterior(a, b, g, q));
 ave_pred_error(1,:)=Z*(sum(sum(sum(sum(weightedprob)))));
 
 weightedq(a, b, g, q, :)=(X_qaction(a, b, g, q, :)) *exp(logposterior(a, b, g, q));
 ave_qaction(1,:)=Z*(sum(sum(sum(sum(weightedq)))));