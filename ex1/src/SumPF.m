function SumPF

format long
window = 100; % Size of each group of terms
upper = 500000; % Number of terms tested
min = ones(1, upper/window);
max = zeros(1, upper/window);
errorRate = zeros(1, upper/window);
sum = 1;
k = 1;


for n = 1:window:upper
    
    for j = 1:window
        k = k + 1;
        next_k = (-1)^length(factor(k)) / k^2; % Working out the next term
        sum = sum + next_k;

        if (sum > max(1, ceil(n/window))) % Finding the maximum sum in the 
                                          % in the window
            max(1, ceil(n/window)) = sum;
        end


        if (sum < min(1, ceil(n/window)))% Finding the minimum sum in the 
                                          % in the window
                                          
            min(1, ceil(n/window)) = sum;
        end 
    end


end

for x = 1:upper/window
    errorRate(1, x) = max(1, x) - min(1, x); % Finding the error rate 
                                             % between the upper bound and 
                                             % lower bound
end

plot(1500:(upper/window), errorRate(1500:(upper/window)))

end