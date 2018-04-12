
function [q, actiontrack, statetrack, prediction_error, qaction, environment]=main_q_learner_function(environment, steps, parameters)
% main q learning for y maze

initialq=parameters(4);

%y-mazebranching y-maze
%daw-simon & Daw (2011) environment (as in paper, without jumps, and rearrangement of doors)
%graph3-3x3 directed graph
%graph5- 5x5 directed graph
%graph6- 6x6 blocked path environment

if  strcmp ('ymaze', environment)  %if environment chosen, initialise environment specific variables   
envir=@ymaze_environment;  %assign function handle for the chosen environment
nnn=input('enter steps of maze: ');
ddd=input('enter number of decisions per state: ');
d1=1/(ddd-1);
aaa=d1*((ddd^(nnn+1))-1); %number of states
bbb=d1*((ddd^nnn)-1); %number of non terminal (decision) states
dist=1+4.*randn(1,(aaa-bbb)); % random rewards for terminal states
save_to_base(aaa);
save_to_base(bbb);
save_to_base(ddd);
save_to_base(dist);
q=initialq*ones(bbb,ddd,steps); %initialise

elseif strcmp ('daw', environment) 
      envir=@daw_environment;
      q=initialq*ones(16,4,steps); %initialise 
elseif strcmp ('graph3', environment)
    envir=@graph3_environment;
    q=initialq*ones(9,4,steps); %initialise  
 elseif strcmp ('graph3b', environment)
    envir=@graph3b_environment;
    q=initialq*ones(9,4,steps); %initialise     
    elseif strcmp ('graphwall', environment) 
    envir=@graphwall_environment;
    q=initialq*ones(10,4,steps); %initialise  
        elseif strcmp ('graph5', environment)
    envir=@graph5_environment;
    q=initialq*ones(25,4,steps); %initialise 
           elseif strcmp ('graph6', environment)
    envir=@graph6_environment;
    q=initialq*ones(36,4,steps); %initialise  
end
clc

%set q-learning parameters
alpha=parameters(1);
beta=parameters(2);
gamma=parameters(3);
%initialise decision variables & movement track
prediction_error=[];
qaction=[];
actiontrack=[];
statetrack=[];



terminal=1; %forces state to be picked


for i=1:steps%-1
   
    h=100*i/steps;
    disp(['progress: ' num2str(h) ' %']) %display percentage of iterations complete
    
if terminal==1;
   state=pickastate(environment); %pick starting state
end
     statetrack(i,1)=state; %records state

[q, error, action, terminal, state_out]=learn_qvalues(q, i, alpha, beta, gamma, state,envir) ; % learns q values based on chosen actions
    qaction(i)=q(state,action,i); %append q value of action chosen to list
    actiontrack(i)=action; %append q value of action chosen to list    
    prediction_error(i)=error; %append PE to record
    state=state_out;

end
end