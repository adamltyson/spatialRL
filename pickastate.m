function state=pickastate(environment)

    if  strcmp ('ymaze', environment) 
   state=1;
     
 elseif strcmp ('graph3', environment)
 x=[1 2 3 4 5 6 7 9];
 y=randperm(8);
 state=x(y(1));  
  elseif strcmp ('graph3b', environment)
 x=[1 2 3 4 5 6 7 9];
 y=randperm(8);
 state=x(y(1));
 elseif strcmp ('daw', environment)
 x=[2 3 5 6 7 8 9 10 11 13 15 16];
 y=randperm(12);
 state=x(y(1));
 elseif strcmp ('graphwall', environment)
 y=randperm(10);
 state=y(1);   
 elseif strcmp ('graph5', environment)
 x=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25];
 y=randperm(24);
 state=x(y(1)); 
 elseif strcmp ('graph6', environment)
 x=[1 2 3 4 5 6 12 13 14 15 16 17 18 19 25 26 27 28 29 30 31 33 36];
 y=randperm(23);
 state=x(y(1));
    end
end