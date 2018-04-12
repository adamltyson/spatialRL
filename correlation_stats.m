function [num, corrq, corrtd, epe, eqa, estparam]=correlation_stats
%returns number of actions, and correlation coefficients for q and td
%estmates parameters, then q-values of chosen actions, and estimated prediction errors based on estimated params
%finds [intercept, slope, correlation_coefficient, pval, transitions,rmse], of correlations between true (directly from algorithm, simulated behavioural data) and estimated decision variables  then plots

clc
sp=[0.4 5.3 0.861 0.3]; %start point, bounds and algorithm for fmincon
lb=[0 0 0 0];
ub=[1 20 1 10];
optimalg='interior-point';

estparam=fmincon(@minimise_function, sp, [], [],[],[], lb, ub,[],optimset('Algorithm',optimalg)) %estimate q-learning parameters using constrained minimisation function

statetrack = evalin('base', 'statetrack'); %retrieve variables created by main q-learning function from the workspace
actiontrack = evalin('base', 'actiontrack');
environment = evalin('base', 'environment');
prediction_error = evalin('base', 'prediction_error');
qaction = evalin('base', 'qaction');

[~,epe,eqa]=estimate_qvalues(estparam, statetrack, actiontrack, environment); % estimate q values, and find estimated prediction errors, and q vals for chosen action, based on estimated parameters


regression_stats=[]; %initialise variable
pred_error_stats=[]; %initialise variable
 qaction_stats=[]; %initialise variable
num=length(epe); % find length of estimated prediction error array
b=regress(epe',[ones(num,1) prediction_error']); %find intercept and gradient of regression line (estimated vs true prediction error from q learning error)
pred_error_stats(2)=b(2); %set intercept and gradient as error stats
pred_error_stats(1)=b(1);
[pred_error_stats(3), pred_error_stats(4)]=corr(epe', prediction_error'); % find regression stats, correlation coeff & pval for estimated vs true prediction error from q learning error (uses statistics toolbox)
corrtd=pred_error_stats(3); 
pred_error_stats(5)=num;



for a=1:num
    squarederror(a)=((epe(a)-prediction_error(a))^2); %squares error term for PE
end

pred_error_stats(6)=sqrt(mean(squarederror)); % rmse
regression_stats(1,:)=pred_error_stats; %all into 1 variable for export to excel 


b=regress(eqa',[ones(num,1) qaction']); %same again for q-val of action chosen
qaction_stats(2)=b(2);
qaction_stats(1)=b(1);
[qaction_stats(3), qaction_stats(4)]=corr(eqa',qaction');
qaction_stats(5)=num;
corrq=qaction_stats(3);

for a=1:num
    squarederror2(a)=((eqa(a)-qaction(a))^2); %squares error term for q-val of chosen action
end
maxw=max(prediction_error); %finds range of data points (for best fit line, and for the text labels)
minw=min(prediction_error);
width=maxw-minw;

rmse2=sqrt(mean(squarederror2)); %RMSE 

qaction_stats(6)=rmse2;
regression_stats(2,:)=qaction_stats;

%%%% correlation plots %%%%%%%%%%%%


 x=minw*1.2:0.1:maxw*1.2;
y=(x*pred_error_stats(2))+pred_error_stats(1); %calculate regression line based on gradient and intercept
plot(x, y); %plot regression line
inter1='Intercept: '; % legend labels
inter2=num2str(pred_error_stats(1));
gradient1=', Gradient: ';
gradient2=num2str(pred_error_stats(2));
legend([inter1 inter2 gradient1 gradient2] ,'Location','NorthWest'); %set legend


hold on
 scatter(prediction_error, epe,3) %scatter plot of estimated vs true
 xlabel('Prediction error')
 ylabel('Estimated Prediction Error')
 title('Estimated against True Prediction Error')
 
 
 rmse1=num2str(pred_error_stats(6));
 pearson1=num2str(pred_error_stats(3));
 pval1=num2str(pred_error_stats(4));
rmse1text='RMSE: ';
rmse1=[rmse1text rmse1];
pearson1text='Pearson Corr Coeff:  ';
pearson1=[pearson1text pearson1];
 pval1text='P-Value:  ';
pval1=[pval1text pval1];
maxw=max(prediction_error);
minw=min(prediction_error);
width=maxw-minw;

text(minw+(width/2),minw+(width/8),rmse1);
text(minw+(width/2),minw+(width/5),pearson1);
text(minw+(width/2),minw+(width/3),pval1);
 
  figure
 maxw=max(qaction);
minw=min(qaction);
width=maxw-minw;
 x=minw*1.2:0.1:maxw*1.2;
y=(x*qaction_stats(2))+qaction_stats(1);
plot(x, y);
inter1='Intercept: ';
inter2=num2str(qaction_stats(1));
gradient1=', Gradient: ';
gradient2=num2str(qaction_stats(2));
legend([inter1 inter2 gradient1 gradient2],'Location','NorthWest' );

hold on
 scatter(qaction, eqa,3)
 xlabel('Q Value of Action Chosen')
 ylabel('Estimated Q Value of Action Chosen')
 title('Estimated against True Q Value of Action Chosen')
 
  rmse1=num2str(qaction_stats(6));
 pearson1=num2str(qaction_stats(3));
 pval1=num2str(qaction_stats(4));
rmse1text='RMSE: ';
rmse1=[rmse1text rmse1];
pearson1text='Pearson Corr Coeff:  ';
pearson1=[pearson1text pearson1];
 pval1text='P-Value:  ';
pval1=[pval1text pval1];
text(minw+(width/2),minw+(width/8),rmse1);
text(minw+(width/2),minw+(width/5),pearson1);
text(minw+(width/2),minw+(width/3),pval1);
 
 
 
 xlswrite('regression_stats.xls',regression_stats,1);
end
