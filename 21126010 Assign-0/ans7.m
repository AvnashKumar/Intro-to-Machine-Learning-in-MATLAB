%Answer-7

clc
close all
clear all

for angle=0:1:360
    x(angle+1)=10*cosd(angle);
    y(angle+1)=10*sind(angle);
    z(angle+1)=0;
end
figure
plot3(x,y,z,'b');
title('Avnash Kumar-3D circle');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
grid on;