function action=action_selection(q, choices, beta)
%chooses which action to take using softmax rule based on state and q values
% global beta;

 for i=1:choices
     a(i)=exp(beta*q(i));
 end
 
 denom=sum(a);
 
 for j=1:choices%-1
     prob(j)=a(j)/denom;
     prob_10000(j)=round(prob(j)*10000);
 end
 
     
 for k=1:choices
     M=k*ones(1, prob_10000(k));
     eval([ 'M' num2str(k) ' = M;' ]);
 end
 
 
 dist=[];
 for j=1:choices
     x=eval([ 'M' num2str(j)]) ;
     dist=[dist x];
 end
  
  num=round(10000*rand);
  num=num-1;
   if num==0
       num=num+1;
   elseif num==-1
       num=num+2;
   end
   action=dist(num);
 
end