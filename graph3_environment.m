function [state_out, reward, terminal, choices]= graph3_environment(state_in, action)
terminal=0;
reward=0;
state_out=0;


choicevec=[1 2 1 1 1 2 1 2 1];
for a=1:9
    if state_in==a
        choices=choicevec(a);
    end
end


invec1=[1 3 4 5 7 9];
outvec1=[4 2 5 6 4 8];
invec2=[2 6 8];
outvec2a=[5 9 5];
outvec2b=[1 3 7];

for b=1:6
    if state_in==invec1(b)
        if action==1
            state_out=outvec1(b);
        end
    end
end

for c=1:3
    if state_in==invec2(c)
        switch action
            case 1
                state_out=outvec2a(c);
            case 2
                state_out=outvec2b(c);
        end
    end
end

if state_out==8
    reward=1;
    terminal=1;
end
    


end














