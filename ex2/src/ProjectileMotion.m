theta = fminbnd(@Dist, 0, pi/2) % Find the optimal theta
Dist(theta)

function d = Dist(theta)

% Find the max distance
maxDist = (450)^2 / 9.8;

options = odeset('events', @event_fun,'reltol', 1e-8);

%Coupled ODEs with their initial conditions

[t, q] = ode45(@(t,z) FrictionForce(t,z), [0, maxDist], [0, 0, 450*cos(theta), 450*sin(theta)], options); 

format long
d_max = q(end, 1);

%We want to find the maximum so we set this to minus
d = -d_max;

plot(q(:,1),q(:,2))
axis([0, 20000, 0, 5200])
title('Plot of Displacement')
xlabel('Displacement (x)')
ylabel('Displacement (y)')
end

%Event function to terminate when the y-value is equal to zero
function [value, isTerminal, direction] = event_fun(t,z)
value = z(2); 
isTerminal = 1;
direction = -1;
end

%Function describing the coupled ODEs
function q = FrictionForce(t,z)
k = 0.00002;
g = 9.8;
m = 6;

q = [z(3); z(4); -k*((sqrt(z(3)^2 + z(4)^2)*z(3)))/m; -k*((sqrt(z(3)^2 + z(4)^2)*z(4)))/m - g];
end
 
