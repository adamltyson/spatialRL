function action_prob=softmax_decision_prob(state, learned_q, beta)
%finds probabilities for actions at states

action_prob=0;
q=learned_q(state,:);

if q(1)==0;
else
    snz=find(q, 1, 'last');

    for i=1:snz
    a(i)=exp(beta*q(i));
    end
 denom=sum(a);
 
 for j=1:snz-1
     action_prob(j)=a(j)/denom;
 end
 action_prob(snz)=1-(sum(action_prob));
end
 


 end

