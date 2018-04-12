clear all
close all
clc
trials=2500;

for b=1:3
alpha(b)=(10^(-b))*5;
q=main_q_learner_function('graph5', trials, alpha(b));

for a=1:trials 
    abc(b,a)=sum(sum(q(:,:,a)));
end
 
end
abc=abc/abc(1,a);
%  abc=abc(:,1:2:2000);
plot(abc')

legend('alpha=0.5','alpha=0.05','alpha=0.005','alpha=0.0005','alpha=0.00005' )
xlabel('trials');
ylabel('normalised mean Q-values');
title('Mean Q-values against number of transitions for 3x3 maze');