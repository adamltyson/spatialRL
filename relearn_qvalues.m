function  [q,epe,eqa]=relearn_qvalues(q, i, alpha, gamma, state, action,envir,epe, eqa)
%re learn q values using state & actions given

q(:,:,i+1)=q(:,:,i); %propagate q
% sze=size(actions);%find number of actions
%   for j=1:sze(2)
      
%     state=states(j); %pick state from sequence
%     action=actions(j); % and corresponding action
    [state_out, reward, terminal, ~]= envir(state, action); %recieve new state and reward from environment
    future_reward=0; %initialise (as 0, so if at terminal state, future reward is 0)
 
   if terminal==0 %if not termina state
     future_reward=max(q(state_out,:,i)); %find value of best decision at new state
   end
    estimated_error=reward + gamma*future_reward - q(state,action,i);%calculate q-learning error value

 q(state, action, i+1)=q(state, action, i)+alpha*estimated_error; %%%update q values for action taken at state

eqa(i)=q(state,action,i); %record estimate of q value of action chosen
epe(i)=estimated_error; %record estimate of prediction error
% end
end