function [state_out, reward, terminal, choices]= graph6_environment(state_in, action)
terminal=0;
reward=0;
state_out=0;


choices=4;



invec=[1 2 3 4 5 6 12 13 14 15 16 17 18 19 25 26 27 28 29 30 31 33 35 36];
outvec1=[1 2 3 4 5 12 18 19 14 15 16 17 18 25 31 26 33 28 35 36 31 33 35 36];
outvec2=[2 3 4 5 6 6 12 14 15 16 17 18 18 19 26 27 28 29 30 30 31 33 35 36];
outvec3=[1 2 3 4 5 6 6 13 14 15 16 17 12 13 19 26 27 28 29 30 25 27 29 30];
outvec4=[1 1 2 3 4 5 12 13 13 14 15 16 17 19 25 25 26 27 28 29 31 33 35 36];

for a=1:24
    if state_in==invec(a)
        switch action
            case 1
                state_out=outvec1(a);
            case 2
                state_out=outvec2(a);
                case 3
                state_out=outvec3(a);
            case 4
                state_out=outvec4(a);
        end
    end
end

if state_out==35
    reward=1;
    terminal=1;
end
    


end