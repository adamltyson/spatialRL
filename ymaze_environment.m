function[state_out, reward, terminal, choices]= ymaze_environment(state_in, action)

%takes as input the state-action pair, and outputs the immediate reward,
%the next state, and whether or not that state is terminal


aaa = evalin('base', 'aaa');
dist = evalin('base','dist');
ddd = evalin('base', 'ddd');
bbb = evalin('base', 'bbb');


terminal=0;
reward=0;
state_out=0;
choices=ddd;

for i=1:bbb
    if state_in==i
        for k=1:ddd
            if action==k
                state_out=(ddd*i)+(k+(1-ddd)); % assigns next state (based on
            end                             % simple branching structure with d choices)
        end
    end
end

if state_out>bbb
    terminal=1;
end


for j=bbb+1:aaa
    if state_out==j
        reward=dist(j-bbb);
    end
end

end