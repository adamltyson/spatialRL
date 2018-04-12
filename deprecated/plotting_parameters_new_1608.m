


normplots5=xlsread('parameterestimates_graph5.xls',1);
normplots10=xlsread('parameterestimates_graph5.xls',2);
normplots50=xlsread('parameterestimates_graph5.xls',3);
normplots500=xlsread('parameterestimates_graph5.xls',4);

close all
hold on
x=0.01:0.01:1;
plot(x,normplots5(:,1),'Color',[0.9 0.1 1],'LineWidth',1)
plot(x,normplots10(:,1),'Color',[0.7 0.3 1],'LineWidth',1)
plot(x,normplots50(:,1),'Color',[0.5 0.5 1],'LineWidth',1)
plot(x,normplots100(:,1),'Color',[0.3 0.7 1],'LineWidth',1)

 plot([0.1,0.1],[200 380],'--r','LineWidth',2)
 xlabel('Learning rate (alpha)')
 ylabel('Normalised negative log likelihood')
 legend('5 trials','10 trials','50 trials','100 trials', 'alpha')
 title('Negative log likelihood vs learning rate')
 hold off
 
 figure
 hold on
x=0.2:0.2:20;
plot(x,normplots5(:,2),'Color',[0.9 0.1 1],'LineWidth',1)
plot(x,normplots10(:,2),'Color',[0.7 0.3 1],'LineWidth',1)
plot(x,normplots50(:,2),'Color',[0.5 0.5 1],'LineWidth',1)
plot(x,normplots100(:,2),'Color',[0.3 0.7 1],'LineWidth',1)

  plot([8,8],[200 900],'--r','LineWidth',2)
 xlabel('Inverse Temperature Parameter (beta)')
 ylabel('Normalised negative log likelihood')
 legend('5 trials','10 trials','50 trials','100 trials', 'beta')
 title('Negative log likelihood vs inverse temperature parameter')
 hold off
%  axis([0 20 200 500]);
 
  
 figure
 hold on
x=0.01:0.01:1;
plot(x,normplots5(:,3),'Color',[0.9 0.1 1],'LineWidth',1)
plot(x,normplots10(:,3),'Color',[0.7 0.3 1],'LineWidth',1)
plot(x,normplots50(:,3),'Color',[0.5 0.5 1],'LineWidth',1)
plot(x,normplots100(:,3),'Color',[0.3 0.7 1],'LineWidth',1)

  plot([0.8,0.8],[200 900],'--r','LineWidth',2)
 xlabel('Delay discount (gamma)')
 ylabel('Normalised negative log likelihood')
  legend('5 trials','10 trials','50 trials','100 trials', 'gamma')
 title('Negative log likelihood vs delay discount')
 hold off
%  axis([0 1 200 600]);
  figure
 hold on
x=0:0.1:9.9;
plot(x,normplots5(:,4),'Color',[0.9 0.1 1],'LineWidth',1)
plot(x,normplots10(:,4),'Color',[0.7 0.3 1],'LineWidth',1)
plot(x,normplots50(:,4),'Color',[0.5 0.5 1],'LineWidth',1)
plot(x,normplots100(:,4),'Color',[0.3 0.7 1],'LineWidth',1)

  plot([0.03,0.03],[0 12e4],'--r','LineWidth',2)
 xlabel('Initial Q value (Q(0))')
 ylabel('Normalised negative log likelihood')
 legend('5 trials','10 trials','50 trials','100 trials', 'Q(O)')
 title('Negative log likelihood vs initial q value')
 hold off
 
%  axis([0 10 0 40000])
 
 
 
 
 