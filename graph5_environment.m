function [state_out, reward, terminal, choices]= graph5_environment(state_in, action)
terminal=0;
reward=0;
state_out=0;


choices=4;



invec=1:25;
outvec1=[6 2 3 4 5 11 7 13 9 10 16 12 18 14 15 21 17 23 19 25 21 22 23 24 25];
outvec2=[1 2 3 4 5 6 8 8 10 10 11 12 14 15 15 16 17 19 19 20 22 22 24 25 25];
outvec3=[1 2 3 4 5 6 2 3 9 3 11 7 13 9 10 16 12 18 14 15 21 17 23 19 20];
outvec4=[1 1 2 3 4 6 6 8 8 10 11 11 13 14 15 16 16 18 19 19 21 22 23 24 25];

for a=1:25
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

if state_out==24
    reward=1;
    terminal=1;
end
    


end






