function [ave_pred_error, ave_qaction, num, corrq, corrtd]=estimate_q_pred_error_corr
%bayesian (rather than max likelihood estimate of decision variables) with
%correlation calculated, and plots


actiontrack = evalin('base', 'actiontrack');
statetrack = evalin('base', 'statetrack');
environment = evalin('base', 'environment');
%finds average sequence of q values and prediction errors based on
%parameter likelihoods

% % % 1. Grid up the 4 (or 5?) dimensional space of parameter values. 
% % % 2. Define a prior over this space. start with a uniform prior. denote the log of the prior probability for grid point i Q_i. (So in the uniform case, if there are G grid points than Q_i = -log N.


fac=5;
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
 maxlogpost=max(max(max(max(logposterior))));
 logposterior=logposterior-maxlogpost+10;
 Z_1=exp(logposterior);    
 norm_factor=sum(sum(sum(sum(Z_1))));
  normexplogpost=Z_1/norm_factor;
 
 %%%%  . For each trial, average the predicted Q-value or prediction error over all parameter combinations (grid points in the parameter space) with the averaging weights being the posterior probabilities:
%  Z=1/norm_factor;
%  posteriorprob=exp(logposterior);

for k=1:length(actiontrack)
    weightedprob(:, :, :, :, k)=times(X_pred_error(:,:,:,:,k),normexplogpost);
end
ave_pred_error(1,:)=sum(sum(sum(sum(weightedprob))));

for j=1:length(actiontrack)
    weightedq(:, :, :, :, j)=times(X_qaction(:,:,:,:,j),normexplogpost);
end
ave_qaction(1,:)=sum(sum(sum(sum(weightedq))));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% prediction_error = evalin('base', 'prediction_error');
% qaction = evalin('base', 'qaction');
% 
% epe=ave_pred_error';
% eqa=ave_qaction';
% regression_stats=[];
% pred_error_stats=[];
%  qaction_stats=[];
% num=length(epe);
% b=regress(epe',[ones(num,1) prediction_error']); %find intercept and gradient of regression line
% pred_error_stats(2)=b(2);
% pred_error_stats(1)=b(1);
% [pred_error_stats(3), pred_error_stats(4)]=corr(epe', prediction_error'); % find regression stats, correlation coeff & pval
% corrtd=pred_error_stats(3);
% pred_error_stats(5)=num;
% 
% 
% 
% for a=1:num
%     squarederror(a)=((epe(a)-prediction_error(a))^2);
% end
% 
% pred_error_stats(6)=sqrt(mean(squarederror)); % rmse
% regression_stats(1,:)=pred_error_stats; %all into 1 for export to excel 
% 
% 
% b=regress(eqa',[ones(num,1) qaction']); %same again
% qaction_stats(2)=b(2);
% qaction_stats(1)=b(1);
% [qaction_stats(3), qaction_stats(4)]=corr(eqa',qaction');
% qaction_stats(5)=num;
% corrq=qaction_stats(3);
% 
% for a=1:num
%     squarederror2(a)=((eqa(a)-qaction(a))^2);
% end
% maxw=max(prediction_error); %range of data points (for best fit line, and for the text labels)
% minw=min(prediction_error);
% width=maxw-minw;
% 
% rmse2=sqrt(mean(squarederror2));
% 
% qaction_stats(6)=rmse2;
% regression_stats(2,:)=qaction_stats;

%%% plotting stuff%%%%%%%%%%%%

% 
%  x=minw*1.2:0.1:maxw*1.2;
% y=(x*pred_error_stats(2))+pred_error_stats(1); %calculate regression line based on gradient and intercept
% plot(x, y); %plot regression line
% inter1='Intercept: ';
% inter2=num2str(pred_error_stats(1));
% gradient1=', Gradient: ';
% gradient2=num2str(pred_error_stats(2));
% legend([inter1 inter2 gradient1 gradient2] ,'Location','NorthWest');
% 
% hold on
%  scatter(prediction_error, epe,3) %scatter plot of estimated vs true
%  xlabel('Prediction error')
%  ylabel('Estimated Prediction Error')
%  title('Estimated against True Prediction Error')
%  
%  
%  rmse1=num2str(pred_error_stats(6));
%  pearson1=num2str(pred_error_stats(3));
%  pval1=num2str(pred_error_stats(4));
% rmse1text='RMSE: ';
% rmse1=[rmse1text rmse1];
% pearson1text='Pearson Corr Coeff:  ';
% pearson1=[pearson1text pearson1];
%  pval1text='P-Value:  ';
% pval1=[pval1text pval1];
% maxw=max(prediction_error);
% minw=min(prediction_error);
% width=maxw-minw;
% 
% text(minw+(width/2),minw+(width/8),rmse1);
% text(minw+(width/2),minw+(width/5),pearson1);
% text(minw+(width/2),minw+(width/3),pval1);
%  
%   figure
%  maxw=max(qaction);
% minw=min(qaction);
% width=maxw-minw;
%  x=minw*1.2:0.1:maxw*1.2;
% y=(x*qaction_stats(2))+qaction_stats(1);
% plot(x, y);
% inter1='Intercept: ';
% inter2=num2str(qaction_stats(1));
% gradient1=', Gradient: ';
% gradient2=num2str(qaction_stats(2));
% legend([inter1 inter2 gradient1 gradient2],'Location','NorthWest' );
% 
% hold on
%  scatter(qaction, eqa,3)
%  xlabel('Q Value of Action Chosen')
%  ylabel('Estimated Q Value of Action Chosen')
%  title('Estimated against True Q Value of Action Chosen')
%  
%   rmse1=num2str(qaction_stats(6));
%  pearson1=num2str(qaction_stats(3));
%  pval1=num2str(qaction_stats(4));
% rmse1text='RMSE: ';
% rmse1=[rmse1text rmse1];
% pearson1text='Pearson Corr Coeff:  ';
% pearson1=[pearson1text pearson1];
%  pval1text='P-Value:  ';
% pval1=[pval1text pval1];
% text(minw+(width/2),minw+(width/8),rmse1);
% text(minw+(width/2),minw+(width/5),pearson1);
% text(minw+(width/2),minw+(width/3),pval1);
%  
%  
%  
%  xlswrite('regression_stats.xls',regression_stats,1);
