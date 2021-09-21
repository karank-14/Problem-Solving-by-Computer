function [p , q] = RatAppCat (N)
% RATAPPCAT The best rational approximation p/q of the Catalan 's constant ,
% among all pairs of (p,q) such that p+q <=N

G = 0.915965594177219;  % Define Catalan's constant

qMax = floor(N/(G+1)); % Calculate upper bound of q
p = 0;
q = 0;
bestApprox = 1; % Variable for best approximation

for i = 1:qMax % The iterate for the q value
    
    j = round(i * G); % The iterate for the p value
    
    currentApprox = abs(j/i-G); % Find the current error
    
    if currentApprox < bestApprox % If current error is better than the 
                                  % previous error, set it as the best
                                  % approximation and save the best p and q
                                  
        bestApprox = currentApprox;
        p = j;
        q = i;      
    end    
end
