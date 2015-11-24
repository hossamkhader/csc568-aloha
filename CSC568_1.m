N =10;                                          %Number of nodes in the system
total_time = 99999;                             %Total number of time slotes for the simulation
S = zeros(101,1);                               %Array of Success rate for each p value
F = zeros(101,1);                               %Array of failure rate for each p value
I = zeros(101,1);                               %Array of idle rate for each p value
best_p = 0;
best_S = 0;
P = 1;
for p = 0:0.01:1                                %repeat for each p value 0-1 with 0.01 increament
    total_success = 0;
    total_collisions = 0;
    total_idle = 0;
    for current_time = 1:total_time             %repeat for each time slots in total time 
        transmission_flag = (rand(1, N) < p);   %generate an arrray of random numbers
        if (sum(transmission_flag) == 1)        %check for successful transmssion
            total_success = total_success + 1;
        end
        if (sum(transmission_flag) == 0)        %check for idle channel
            total_idle = total_idle + 1;
        end
        if (sum(transmission_flag) > 1)         %check for collision
            total_collisions = total_collisions + 1;
        end
    end
    S(P,1) = total_success/total_time;          %calculate the success rate for the p value
    F(P,1) = total_collisions/total_time;       %calculate the failure rate for the p value
    I(P,1) = total_idle/total_time;             %calculate the idle rate for the p value
    best_S = max(S(P),best_S);                  %compare the S to find S*
    if(best_S == S(P))
        best_p = p;
    end
    P = P + 1;
end

display(best_S,'S*');
display(best_p,'p*');

x = 0:0.01:1;
figure;
plot(x,S,'g',x,F,'r',x,I,'b');
legend('success','collision','idle');
title('Throughput S as a function of different p values');
xlabel('p');