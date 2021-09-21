maxDist = (450)^2 / 9.8;
theta = pi/4;
[t, q] = ode45(@(t,z) FrictionForce(t,z), [0, maxDist], [0, 0, 450*cos(theta), 450*sin(theta)]); 

plot(q(:,1),q(:,2))
axis([0, 20000, 0, 5200])