clear all;
close all;
clc;

fprintf('Loading the data....');
data=load("hw1_data1.txt")
fprintf('Enter to continue.... \n');
pause;

theta=[3.35, 0.0528];
m=length(data);
X=[ones(m,1) data(:,1)];
Y_actual=data(:,2)
Y_pridict=X*theta'

error=Y_pridict-Y_actual;
MAE=(1/m)*sum(abs(Y_pridict-Y_actual))
MSE= (1/m)*sum(error.^2)
RMSE=sqrt(MSE)
