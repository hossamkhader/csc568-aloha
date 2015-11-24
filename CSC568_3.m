total_time = 999;                                           %Total number of time slotes for the simulation
L = 5;                                                      %The size of the frame in time slots
S = zeros(101);                                             %Array of Success rate for each p value
p_perN = zeros(100,1);                                      %Array of p* values for number of nodes
S_perN = zeros(100,1);                                      %Array of S* values for each number of nodes

for N = 1:100                                               %repeat for each number of nodes 1-100
    best_p = 0;
    best_S = 0;
    P = 1;
    for p = 0:0.001:1                                        %repeat for each p value 0-1 with 0.01 increament
        total_success = 0;
        total_collisions = 0;
        total_idle = 0;
        for current_time = 1:total_time                     %repeat for each time slots in total time
            for l = 1:L
                transmission_flag = (rand(L, N) < p);       %generate an arrray of random numbers  
            end
            if (sum(sum(transmission_flag)) == 1 && sum(transmission_flag(1,:)) == 1)           %check for successful transmssion for a frame of size L
                total_success = total_success + 1;
            end
            if (sum(transmission_flag) == 0)                %check for idle channel
                total_idle = total_idle + 1;
            end
            if (sum(transmission_flag) > 1)                 %check for collision
                total_collisions = total_collisions + 1;
            end
        end
    
        S(P) = total_success/total_time;                    %calculate the success rate for the p value
        best_S = max(S(P),best_S);                          %compare the S to find S*
        if(best_S == S(P))
            best_p = p;
        end

        P = P + 1;
    end
    S_perN(N) = best_S;
    p_perN(N) = best_p;
end
x=1:100;
figure;
plot(x,p_perN,x,S_perN);
legend('p*','S*');
title('p* and S* as a function of different N values (when L=5)');
xlabel('N');