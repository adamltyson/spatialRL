
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function importancesampler_plots


prediction_error = evalin('base', 'prediction_error');
qaction = evalin('base', 'qaction');
est_pred_error = evalin('base', 'est_pred_error');
est_Qaction = evalin('base', 'est_Qaction');

epe=est_pred_error';
eqa=est_Qaction';
regression_stats=[];
pred_error_stats=[];
 qaction_stats=[];
num=length(epe);
b=regress(epe,[ones(num,1) prediction_error']); %find intercept and gradient of regression line
pred_error_stats(2)=b(2);
pred_error_stats(1)=b(1);
[pred_error_stats(3), pred_error_stats(4)]=corr(epe, prediction_error'); % find regression stats, correlation coeff & pval
corrtd=pred_error_stats(3);
pred_error_stats(5)=num;



for a=1:num
    squarederror(a)=((epe(a)-prediction_error(a))^2);
end

pred_error_stats(6)=sqrt(mean(squarederror)); % rmse
regression_stats(1,:)=pred_error_stats; %all into 1 for export to excel 


b=regress(eqa,[ones(num,1) qaction']); %same again
qaction_stats(2)=b(2);
qaction_stats(1)=b(1);
[qaction_stats(3), qaction_stats(4)]=corr(eqa,qaction');
qaction_stats(5)=num;
corrq=qaction_stats(3);

for a=1:num
    squarederror2(a)=((eqa(a)-qaction(a))^2);
end
maxw=max(prediction_error); %range of data points (for best fit line, and for the text labels)
minw=min(prediction_error);
width=maxw-minw;

rmse2=sqrt(mean(squarederror2));

qaction_stats(6)=rmse2;
regression_stats(2,:)=qaction_stats;

%%% plotting stuff%%%%%%%%%%%%


 x=minw*1.2:0.1:maxw*1.2;
y=(x*pred_error_stats(2))+pred_error_stats(1); %calculate regression line based on gradient and intercept
plot(x, y); %plot regression line
inter1='Intercept: ';
inter2=num2str(pred_error_stats(1));
gradient1=', Gradient: ';
gradient2=num2str(pred_error_stats(2));
legend([inter1 inter2 gradient1 gradient2] ,'Location','NorthWest');

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
 
 
 
  
 
%    xlswrite('regression_stats_6.xls',regression_stats,8);
end