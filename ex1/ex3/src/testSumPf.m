function testSumPf

format long
block = 100;
upper = 1000000;
min = ones(1, upper/block);
max = zeros(1, upper/block);
errorRate = zeros(1, upper/block);
sum = 1;
k = 1;


for n = 1:block:upper
    
    for j = 1:block
        k = k + 1;
        next_k = (-1)^length(factor(k)) / k^2;
        sum = sum + next_k;

        if (sum > max(1, ceil(n/block)))
            max(1, ceil(n/block)) = sum;
        end


        if (sum < min(1, ceil(n/block)))
            min(1, ceil(n/block)) = sum;
        end
    end


end

%plot(1:(upper/block), max)
hold on
%plot(1:(upper/block), min)

for x = 1:upper/block
    errorRate(1, x) = max(1, x) - min(1, x);
end

plot(1:100:(upper/block), errorRate)

end