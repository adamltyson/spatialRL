






beta=8;

%learnedq=main_q_learner_function(environment, trials, alpha);

b=size(q);
state_action_prob=zeros(b);
for m=1:b(3)
for n=1:b(1);
   
    a=softmax_decision_prob(n, q(:,:,m), beta);
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
        log_prob(x,y,w)=-10;
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
sze=size(statetrack);

counter=0;

for k=1:sze(1)
a=find(actiontrack(k,:), 1, 'last');
for b=1:a
    total_log_prob= total_log_prob+log_prob(statetrack(k,b), actiontrack(k,b),k);
     counter=counter+1;
     prob99(counter)=total_log_prob;
end

end
total_log_prob

