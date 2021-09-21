function ctn = CubicTaxicabNum(N)
% CUBICTAXICABNUM return the smallest cubic taxicab number greater than
% or equal to N
count = 0;
N = N - 1;

while(count < 2)   
    count = 0;      % Counter for pair of cubes
    
    UB = floor(nthroot(N, 3));  
    
    i1 = 1;  % Set the left iterate as the lower bound
    
    i2 = UB; % Set the right iterate as the upper bound
    
    while i1 <= i2 % Check to see if we have tested all values yet
        
        cubed = i1^3 + i2^3; 
        
        if (cubed == N) % If current sum is the N, we look for the next
                        % pair of cubes
                        
            i1 = i1 + 1; 
            i2 = i2 - 1;
            count = count + 1;

        elseif (cubed < N)  % If current sum is too small, we move the left
                            % iterate
            
            i1 = i1 + 1;
            
        elseif (cubed > N)  % If current sum is too small, we move the
                            % right iterate
            
            i2 = i2 - 1;
        end
    end
    
    ctn = N;    % Set the output as current N 
    N = N + 1;  % Test the next N
    
end
% The program will end once we have found the closest taxicab number as the
% the count of pair of cubes will be two. 
end
