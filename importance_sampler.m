%    function [est_pred_error, est_Qaction, W, effec_sampsize, X]=importance_sampler
% samples from the PDF using a laplace approximation as the proposal
% distribution

actiontrack = evalin('base', 'actiontrack');
statetrack = evalin('base', 'statetrack');
environment = evalin('base', 'environment');

[mu,~,~,~,~,~,hessian]=fmincon(@minimise_function, [0.4 5.3 0.861 0.3], [], [],[],[], [0 0 0 0], [1 20 1 10],[],optimset('Algorithm','interior-point')); %ML parameters & hessian
sigma=inv(hessian); %covariance matrix

samp_size=100;  %number of samples to take
X=mvnrnd(mu, sigma, samp_size); % take sample


for i=1:samp_size
     h=100*i/samp_size;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete
% if X(i, :)>=0          %discard all sampled X that are not in the support of p   
aa(i)=minimise_function(X(i, :));
% bb(i)=log(mvnpdf(X(i, :), mu, sigma));

bb(i)=(-0.5.*(X(i,:)-mu))*hessian*(X(i,:)-mu)';

logW(i) = -(aa(i)-bb(i)); % calculate importance weight for sample i

[~,epred_error(i, :),eqaction(i, :)]=estimate_qvalues(X(i, :), statetrack, actiontrack, environment); %find series of estimated pred errors and q actions for each parameter combination
% else
% logW(i)=-10000;                 % ignore values
% epred_error(i,:)=0;
% eqaction(i,:)=0;
% samp_size = samp_size - 1;
% end
end

logW=logW-max(logW);
eW=exp(logW);
W=eW/sum(eW);

for j=1:samp_size
Ipe(j,:) = epred_error(j,:)*W(j);           % weigh the function
 Iqa(i,:)=eqaction(j,:)*W(j);
end

est_pred_error = (sum(Ipe))/sum(W); % perform summation 
est_Qaction= (sum(Iqa))/sum(W);

effec_sampsize=0;
for a=1:samp_size
    if W(a)>=1/samp_size
        effec_sampsize=effec_sampsize+1;
    end
end



%    end
