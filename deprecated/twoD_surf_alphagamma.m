alpha=0.1;
beta=8;
gamma=0.8;
q=0;


factor=20;


for b=1:factor
    h=100*(b)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
  gamma=b/factor;
    for g=1:factor
       alpha=g/factor;
        proba(b,g)=minimise_function([alpha beta gamma q]);
    end
end
% proba=-proba;
figure;
surfc(proba)
xlabel('gamma');
ylabel('alpha');
zlabel('-ve log likelihood');
set(gca,'YTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
set(gca,'XTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
title('Negative log likelihood-alpha & gamma');