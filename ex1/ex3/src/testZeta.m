function testZeta
A = zeros(100,1);
for i = 1:100
   A(i,1)= mod(length(factor(i)), 2);
end

idx=A==1

out = sum(idx(:))