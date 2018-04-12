
    plot10=xlsread('probabilities_alpha3.xls',1);
    plot20=xlsread('probabilities_alpha3.xls',2);
plot30=xlsread('probabilities_alpha3.xls',3);
plot40=xlsread('probabilities_alpha3.xls',4);
plot50=xlsread('probabilities_alpha3.xls',5);
zzz=zeros(5, 50000);
%  zzz(1,:)=plot10';
%  zzz(2,:)=plot20';
%   zzz(3,:)=plot30';
%    zzz(4,:)=plot40';
%     zzz(5,:)=plot50';
%     
figure;

% plot(zzz)
 plot(plot10,'Color',[0.9 0.1 1])
 hold on
 plot(plot20,'Color',[0.7 0.3 1])
 plot(plot30,'Color',[0.5 0.5 1])
 plot(plot40,'Color',[0.3 0.7 1])
 plot(plot50,'Color',[0.1 0.9 1])
 axis([0 3702 -1500 0])
xlabel('Number of S-A pairs visited')
ylabel('Cumulative log likelihood of actions');
title('Cumulative log likelihood of actions vs number of S-A pairs visited, for each value of alpha')
legend('{-\alpha} =0.5','{-\alpha} =0.1','{-\alpha} =0.01','{-\alpha} =0.001','{-\alpha} =0.0001' )