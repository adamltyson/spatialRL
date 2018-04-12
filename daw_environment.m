function [state_out, reward, terminal, choices]= daw_environment(state_in, action)

terminal=0;
reward=0;
state_out=0;
choices=0;
choice_vec=[1 1 1 1 2 2 2 2 1 2 1 2 1 2 2 1];


in_vec_a=[1 2 3 4 9 11 13 16];
in_vec_b=[5 6 7 8 10 12 14 15];
state_vec_a=[2 6 2 3 5 15 9 12];
state_vec_b1=[6 10 11 7 11 8 10 16];
state_vec_b2=[1 7 3 7 9 11 13 14];


for i=1:16
    if state_in==i;
        choices=choice_vec(i);
    end
end


for a=1:8;
    if state_in==in_vec_a(a)
        if action==1
            state_out=state_vec_a(a);
            
        end
    end
end

for b=1:8
    if state_in==in_vec_b(b)
        if action==1
            state_out=state_vec_b1(b);
        elseif action==2
            state_out=state_vec_b2(b);
        end
    end
end

    

if state_out==1 || state_out==14
    reward=2;
    terminal=1;
elseif state_out==4|| state_out==12
    reward=3;
    terminal=1;
end
end

