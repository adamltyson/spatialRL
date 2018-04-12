function [q, error, action, terminal, state_out]=learn_qvalues(q, i, alpha, beta, gamma, state,envir)  % learns q values based on chosen actions

%chooses actions based on q-vals, learns next q-vals based on reinforcement
%recieved

q(:,:,i+1)=q(:,:,i); %propagate q to next time step

  
    [~, ~, ~, choices]= envir(state, 0); %gets number of available actions from environment function (graph3, graph5 etc)
    action=action_selection(q(state,:,i), choices, beta); %choose action based on softmax decision rule

 
    [state_out, reward, terminal, ~]= envir(state, action); %pass state, and action chosen to environment and recieve new state and reward
     
    future_reward=0; %initialise (as 0, so if at terminal state, future reward is 0) 
   if terminal==0 % if not terminal (reward) state
     future_reward=max(q(state_out,:,i)); %find value of best decision at new state
   end
    error=reward + gamma*future_reward - q(state,action,i); %calculate q-learning error value
  
    q(state, action, i+1)=q(state, action, i)+alpha*error ;%update q values for action taken at state


end
