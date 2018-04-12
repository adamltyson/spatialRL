% all_2Ds.m
% plots in 2D parameter estimate surfaces
alpha=0.1;
beta=8;
gamma=0.8;
q=0;


factor=40;


for b=1:factor
    h=100*(b)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
  beta=b*20/factor;
    for g=1:factor
       alpha=g/factor;
        proba(b,g)=minimise_function([alpha beta gamma q]);% finds array of likelihoods for parameter combinations
    end
end
% proba=-proba;
figure;
surfc(proba)
xlabel('beta');
ylabel('alpha');
zlabel('-ve log likelihood');
set(gca,'YTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
title('Negative log likelihood-alpha & b');
%%%%%%%%%%%%%

%%%%%%%%%%%%%

alpha=0.1;
beta=8;
gamma=0.8;
q=0;





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

%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%

alpha=0.1;
beta=8;
gamma=0.8;
q=0;





for b=1:factor
    h=100*(b)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
  alpha=b/factor;
    for g=1:factor
       q=g/factor;
        proba(b,g)=minimise_function([alpha beta gamma q]);
    end
end
% proba=-proba;
figure;
surfc(proba)
xlabel('alpha');
ylabel('initial q val');
zlabel('-ve log likelihood');
set(gca,'YTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
set(gca,'XTickLabel',{'0';'0.25';'0.5';'0.75';'1'})


title('Negative log likelihood-initial q value & alpha');


%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%

alpha=0.1;
beta=8;
gamma=0.8;
q=0;





for b=1:factor
    h=100*(b)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
  beta=b*20/factor;
    for g=1:factor
       gamma=g/factor;
        proba(b,g)=minimise_function([alpha beta gamma q]);
    end
end
% proba=-proba;
figure;
surfc(proba)
xlabel('beta');
ylabel('gamma');
zlabel('-ve log likelihood');
set(gca,'YTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
title('Negative log likelihood-gamma & beta');


%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%

alpha=0.1;
beta=8;
gamma=0.8;
q=0;





for b=1:factor
    h=100*(b)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
  beta=b*20/factor;
    for g=1:factor
       q=g/factor;
        proba(b,g)=minimise_function([alpha beta gamma q]);
    end
end
% proba=-proba;
figure;
surfc(proba)
xlabel('beta');
ylabel('initial q val');
zlabel('-ve log likelihood');
set(gca,'YTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
title('Negative log likelihood-initial q value & beta');

%%%%%%%%%%

%%%%%%%%%%%%

alpha=0.1;
beta=8;
gamma=0.8;
q=0;





for b=1:factor
    h=100*(b)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
  gamma=b/factor;
    for g=1:factor
       q=g/factor;
        proba(b,g)=minimise_function([alpha beta gamma q]);
    end
end
% proba=-proba;
figure;
surfc(proba)
xlabel('gamma');
ylabel('initial q val');
zlabel('-ve log likelihood');
set(gca,'YTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
set(gca,'XTickLabel',{'0';'0.25';'0.5';'0.75';'1'})


title('Negative log likelihood-initial q value & gamma');