function total_log_prob=prob_for_parameter(statesequence, actionsequence, parameters, environment)

beta=parameters(2);
learned_q=estimate_qvalues(parameters, statesequence, actionsequence, environment); % relearn the q values based on the sequence of actions and states

b=size(learned_q);
state_action_prob=zeros(b);
for m=1:b(3)
for n=1:b(1);
   
    a=softmax_decision_prob(n, learned_q(:,:,m), beta);
    c=size(a);
    if c(2)==0
    else
    state_action_prob(n,1:c(2),m)=a;
    end
end
end

e=size(state_action_prob);
log_prob=zeros(e);
for w=1:e(3)
for x=1:e(1)
for y=1:e(2)
    if state_action_prob(x,y,w)==0
        log_prob(x,y,w)=0;
    else
        log_prob(x,y,w)=log(state_action_prob(x,y,w));
    end
end
end
end
%%%%%%%

% adds up log probabilities for the action taken at each state, and returns
% the total probability for that path
 total_log_prob=0;
sze=size(statesequence);
sze2=size(learned_q);
for u=1:sze2(3)
for k=1:sze(1)
a=find(actionsequence(k,:), 1, 'last');
for b=1:a
    total_log_prob= total_log_prob+log_prob(statesequence(k,b), actionsequence(k,b),u);
end
end
end
end
