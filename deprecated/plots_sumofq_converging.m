function abc=diffalpha(trials,alpha);


qq=main_q_learner_function('graph3', trials, alpha);

for a=1:trials 
    abc(a)=sum(sum(qq(:,:,a)));
end

end