function [estq,epe,eqa]=estimate_qvalues(parameters, statesequence, actionsequence, environment)

% estimate decision variables using parameter estimates

%set q-learning parameters
alpha=parameters(1);
beta=parameters(2);
gamma=parameters(3);
initialq=parameters(4);

lngth=length(statesequence); %find size of statetrack/statesequence array

if  strcmp ('ymaze', environment)  %if environment chosen
aaa = evalin('base', 'aaa');
dist = evalin('base','dist');
ddd = evalin('base', 'ddd');
bbb = evalin('base', 'bbb');  
envir=@ymaze_environment;  %assign function handle for the chosen environment
q=initialq*ones(bbb,ddd,lngth); %initialise
elseif strcmp ('daw', environment) 
      envir=@daw_environment;
      q=initialq*ones(16,4,lngth); %initialise    
elseif strcmp ('graph3', environment) 
    envir=@graph3_environment;
    q=initialq*ones(9,4,lngth); %initialise 
elseif strcmp ('graph5', environment)
    envir=@graph5_environment;
    q=initialq*ones(25,4,lngth); %initialise 
elseif strcmp ('graph6', environment)
    envir=@graph6_environment;
    q=initialq*ones(36,4,lngth); %initialise  
end
epe=[]; %initialise estimated prediction error array
eqa=[]; % initialise estimated q-val of action chosen array

for i=1:lngth %for number of trials
%    p=find(statesequence(i,:), 1, 'last'); %find number of states traversed in trial
%    states=statesequence(i,1:p); %select array of states traversed in trial 
%    actions=actionsequence(i,1:p-1); %select array of actions traversed in trial

   [q,epe,eqa]=relearn_qvalues(q, i, alpha, gamma, statesequence(i), actionsequence(i),envir,epe, eqa) ; % learns q values based on chosen actions
   end
estq=q; %assign estimated q-value to pass back from function
end
