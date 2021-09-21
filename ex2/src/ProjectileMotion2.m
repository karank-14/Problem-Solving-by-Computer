format long

%Find the two thetas at 15000m
theta1 = fzero(@(theta) Dist(theta) - 15000, 0.4)
theta2 = fzero(@(theta) Dist(theta) - 15000, 1.2)

Dist2(theta1)
Dist2(theta2)

function d = Dist(theta)
maxDist = (450)^2 / 9.8;
options = odeset('events', @event_fun,'reltol', 1e-8);

[t, q] = ode45(@(t,z) FrictionForce(t,z), [0, maxDist], [0, 0, 450*cos(theta), 450*sin(theta)], options); 

d_max = q(end, 1);
d = d_max;

plot(q(:,1),q(:,2))
axis([0, 20000, 0, 5200])
end

function d = Dist2(theta)
maxDist = (450)^2 / 9.8;
options = odeset('events', @event_fun2,'reltol', 1e-8);

[t, q] = ode45(@(t,z) FrictionForce(t,z), [0, maxDist], [0, 0, 450*cos(theta), 450*sin(theta)], options); 

d_max = q(end, 1);
d = d_max;

plot(q(:,1),q(:,2))
axis([0, 20000, 0, 5200])
end

function [value, isTerminal, direction] = event_fun(t,z)
value = z(2); 
isTerminal = 1;
direction = -1;
end

%Event function to terminate when the x value is 12000
function [value, isTerminal, direction] = event_fun2(t,z)
value = z(1) - 12000; 
isTerminal = 1;
direction = 1;
end

function q = FrictionForce(t,z)
k = 0.00002;
g = 9.8;
m = 6;

q = [z(3); z(4); -k*((sqrt(z(3)^2 + z(4)^2)*z(3)))/m; -k*((sqrt(z(3)^2 + z(4)^2)*z(4)))/m - g];
end
 
