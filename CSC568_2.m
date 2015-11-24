total_time = 99999;                                 %Total number of time slotes for the simulation
S = zeros(101);                                     %Array of Success rate for each p value
p_perN = zeros(100,1);                              %Array of p* values for number of nodes
S_perN = zeros(100,1);                              %Array of S* values for each number of nodes

for N = 1:100                                       %repeat for each number of nodes 1-100
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
    
        S(P) = total_success/total_time;            %calculate the success rate for the p value
        best_S = max(S(P),best_S);                  %compare the S to find S*
        if(best_S == S(P))
            best_p = p;
        end

        P = P + 1;
    end
    p_perN(N,1) = best_p;
    S_perN(N,1) = best_S;
end
x=1:100;
figure;
plot(x,p_perN,x,S_perN);
legend('p*','S*');
title('p* and S* as a function of different N values');
xlabel('N');