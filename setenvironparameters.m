function [envir, q]=setenvironparameters(environment, initialq)


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