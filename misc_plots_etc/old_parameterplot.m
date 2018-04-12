function probarrays=old_parameterplot(parameters)
close all

alpha=parameters(1);
beta=parameters(2);
gamma=parameters(3);
q=parameters(4);
factor=100;

%%%%%%%%%%%%%%%%%%%%%
for a=1:factor;
     h=100*(a+1)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
 alpha=a/factor;   
probarrays(a,1)=minimise_function([alpha,beta,gamma,q]);
end
x=0.01:0.01:1;
figure
plot(x,probarrays(:,1))
xlabel('alpha')
ylabel('-ve log liklihood')

alpha=parameters(1);
beta=parameters(2);
gamma=parameters(3);
q=parameters(4);
%%%%%%%%%%%%%%%%%%%%%%%%%
for a=1:factor;
     h=100*(a+1)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
 beta=(a*20)/factor;
probarrays(a,2)=minimise_function([alpha,beta,gamma,q]);
end
x=0.2:0.2:20;
figure
plot(x,probarrays(:,2))
xlabel('beta')
ylabel('-ve log liklihood')
alpha=parameters(1);
beta=parameters(2);
gamma=parameters(3);
q=parameters(4);
%%%%%%%%%%%%%%%%%%%%%%
for a=1:factor;
     h=100*(a+1)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
 gamma=a/factor;   
probarrays(a,3)=minimise_function([alpha,beta,gamma,q]);
end
figure
x=0.01:0.01:1;
plot(x,probarrays(:,3))
xlabel('gamma')
ylabel('-ve log liklihood')
alpha=parameters(1);
beta=parameters(2);
gamma=parameters(3);
q=parameters(4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%

for a=1:factor;
     h=100*(a+1)/factor;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete  
 q=(a*10)/factor;   
probarrays(a,4)=minimise_function([alpha,beta,gamma,q]);
end
figure
x=0:0.01:0.99;
plot(x,probarrays(:,4))
xlabel('initial qvalue')
ylabel('-ve log liklihood')

end








