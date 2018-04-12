% main q learning for y maze

clear all
close all


initialq=0;
environment=input('Enter environment: ', 's');
trials=input('Enter number of iterations: ');
tic

if  strcmp ('ymaze', environment)  %if environment chosen  
global n;
global b;
global a;
global dist;
global d;      
envir=@ymaze_environment;  %assign function handle for the chosen environment
n=input('enter steps of maze: ');
d=input('enter number of decisions per state: ');
d1=1/(d-1);
a=d1*((d^(n+1))-1); %number of states
b=d1*((d^n)-1); %number of non terminal (decision) states
dist=1+4.*randn(1,(a-b)); % random rewards for terminal states
q=initialq*ones(b,d,trials); %initialise
elseif strcmp ('daw', environment) 
      envir=@daw_environment;
      q=initialq*ones(16,4,trials); %initialise    
elseif strcmp ('graph3', environment)
    envir=@graph3_environment;
    q=initialq*ones(9,4,trials); %initialise   
    elseif strcmp ('graph5', environment)
    envir=@graph5_environment;
    q=initialq*ones(25,4,trials); %initialise 
end

clc
beta=8; %(reciprocal) temperature parameter for softmax decision rule
alpha=0.1; %learning rate
gamma=0.8; %delay discount
prediction_error=[];
qaction=[];
actiontrack=[];
statetrack=[];
for i=1:trials-1
   
    h=100*(i+1)/trials;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete

   %pick starting state (either 1 for y maze, or a random (non terminal
   %state for graphs)
 if  strcmp ('ymaze', environment) 
   state=1;
     
 elseif strcmp ('graph3', environment)
 x=[1 2 3 4 5 6 7 9];
 y=randperm(8);
 state=x(y(1));  

 elseif strcmp ('daw', environment)
 x=[2 3 5 6 7 8 9 10 11 13 15 16];
 y=randperm(12);
 state=x(y(1));
   
    elseif strcmp ('graph5', environment)
 x=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25];
 y=randperm(24);
 state=x(y(1));  
 end
 [q, actiontrack, statetrack, prediction_error, qaction]=learn_qvalues(q, i, alpha, beta, gamma, state,envir, actiontrack, statetrack, prediction_error, qaction) ; % learns q values based on chosen actions
 statetrack(i,1)=state; %sets first state for state track

end

toc
