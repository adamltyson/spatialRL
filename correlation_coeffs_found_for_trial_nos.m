% correlation_coeffs_found_for_trial_nos.m
%runs main q learning function, and find the correlation coefficients for
%decision variable estimates (15 times, for varying numbers of trials)

clear all
close all
clc

nums=[1 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 8];
for a=1:15
    
trials=nums(a);

[q, actiontrack, statetrack, prediction_error, qaction, environment]=main_q_learner_function('graph6',trials, [0.4 5.3 0.861 0.3]);
[corr(a,1), corr(a,2), corr(a,3)]=correlation_stats;

end


corrsort=sortrows(corr);
plot(corrsort')