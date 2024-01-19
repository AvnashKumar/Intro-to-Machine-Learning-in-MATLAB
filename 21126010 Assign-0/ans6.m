%Answer-6

clc
close all
clear all

for angle=0:1:360
    x(angle+1)=10*cosd(angle);
    y(angle+1)=10*sind(angle);
end
figure
plot(x,y,'b');
title('Avnash Kumar - 2D circle');
xlabel('x-axis');
ylabel('y-axis');
grid on;