%plot regression lines + p value for each number of trials  &&&& scatter
%plot

%plot r/p value vs transitions
%plot rms error vs transitions

close all
for a=1:6
prediction_error_statistics(a,:)=xlsread('regression_stats_6.xls',a,'A1:F1');
qaction_statistics(a,:)=xlsread('regression_stats_6.xls',a,'A2:F2');
end
x=0.001:0.001:1;

% 
% for b=1:6
%     
%    pred_slope(b,:)=(prediction_error_statistics(b,2)*x)+(prediction_error_statistics(b,1));
%    qaction_slope(b,:)=(qaction_statistics(b,2)*x)+(qaction_statistics(b,1));
% end
%  plot(pred_slope,x);
%  legend('233 S-A pairs r=0.941', '382 S-A pairs r=0.921', '813 S-A pairs r=0.919', '1906 S-A pairs r=0.970', '3702 S-A pairs r=0.976', '18647 S-A pairs r=0.982')
% title('Estimated prediction error vs Actual prediction error')
% xlabel('Actual Prediction error');
% ylabel('Estimated prediction error');
%  figure
%  plot(qaction_slope,x);
%   legend('233 S-A pairs r=0.974', '382 S-A pairs r=0.956', '813 S-A pairs r=0.883', '1906 S-A pairs r=0.973', '3702 S-A pairs r=0.935', '18647 S-A pairs r=0.979')
% title('Estimated Q-value of action vs Actual Q-value of action')
%  xlabel('Actual Q-value');
%  ylabel('Estimated Q-value');

  hold on
 plot(qaction_statistics(:,5),qaction_statistics(:,4),'g','LineWidth',1.3)%%pval
 plot(prediction_error_statistics(:,5),prediction_error_statistics(:,4),'r','LineWidth',1.3)%%pval

 legend( 'Q-value of chosen action','TD error')
 xlabel('Number of state-action pairs in sequence');
 ylabel('P-value');
title('P-value against number of S-A pairs in sequence');
% 
% axis([0 2e4 -1e-111 6e-111])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
 hold on
  plot(qaction_statistics(:,5),qaction_statistics(:,3),'g','LineWidth',1.3)%%corr_coeff
 plot(prediction_error_statistics(:,5),prediction_error_statistics(:,3),'r','LineWidth',1.3)%%corr_coeff
% 
 legend( 'Q-value of chosen action','TD error')
 xlabel('Number of state-action pairs in sequence');
 ylabel('Pearsons linear correlation coefficient');
 title('Pearsons linear correlation coefficient against number of S-A pairs in sequence');
 
 figure
 hold on
  plot(qaction_statistics(:,5),qaction_statistics(:,6),'g','LineWidth',1.3)%%RMSE
 plot(prediction_error_statistics(:,5),prediction_error_statistics(:,6),'r','LineWidth',1.3)%%rmse
% 
 legend( 'Q-value of chosen action','TD error')
 xlabel('Number of state-action pairs in sequence');
 ylabel('RMSE');
 title('RMSE against number of S-A pairs in sequence');

 
 
 
 