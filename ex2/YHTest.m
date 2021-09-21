%Projectile motion with friction
g = 10; s= 10; theta = pi/6; m = 1; K = 0.1;
projode = @(t,z) [z(3); z(4); -K*z(3)/m*sqrt(z(3)^2+z(4)^2); -g-K*z(4)/m*sqrt(z(3)^2+z(4)^2)];
[t,z] = ode45(projode,[0 2*s/g],[0 0 s*cos(theta) s*sin(theta)]);
x = s*cos(theta)*t;
y = s*sin(theta)*t-g*t.^2/2;
plot(z(:,1),z(:,2),x,y,'*')
