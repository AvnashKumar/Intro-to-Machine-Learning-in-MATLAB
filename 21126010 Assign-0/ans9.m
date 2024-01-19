%Answer-9
clc
clear all
close all
Points = 10; 
slope = 10; 


x = linspace(0, 10,Points);
y = slope* x + randn(1,Points);

% Plotting the data
plot(x, y, 'o')
xlabel('x value');
ylabel('y value');
hold on

% Polynomial curve fitting
degree = 3; % Degree of the polynomial curve
coefficients = polyfit(x, y, degree);

% Generate fitted curve
xFit = linspace(0, 10, 10); 
yFit = polyval(coefficients, xFit); 

% Plotting the data and fitted curve
plot(x, y, '-b', xFit, yFit)
xlabel('x - value')
ylabel('y- value')
grid on;