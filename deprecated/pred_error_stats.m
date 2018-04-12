

pred_error_stats=[];
qaction_stats=[];
num=length(epe);
b=regress(epe',[ones(num,1) prediction_error']);
pred_error_stats(2)=b(2);
pred_error_stats(1)=b(1);
[pred_error_stats(3), pred_error_stats(4)]=corr(epe', prediction_error');

pred_error_stats(5)=num;

pred_error_stats


b=regress(eqa',[ones(num,1) qaction']);
qaction_stats(2)=b(2);
qaction_stats(1)=b(1);
[qaction_stats(3), qaction_stats(4)]=corr(eqa',qaction');
qaction_stats(5)=num;
qaction_stats
