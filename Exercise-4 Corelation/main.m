
clc;
clear all;
close all;
data = readtable('advertisement.xlsx'); % Load your data
correlation_matrix = corrcoef(data{:, :}); 
disp('Correlation Matrix:');
disp(correlation_matrix);

y=table2array(data(:,end));
m=length(y);
theta=zeros(3,1);
X=table2array(data(:,1:2));
 mu=mean(X);
 sigma=std(X);
 X=(X-mu)./sigma;
 X=[ones(m,1),X];
J=ComputeCost(X,y,theta);
alpha=0.1;
num_iters=1000;

[theta Jh]=gradientDes(X, y, theta, alpha, num_iters);
plot([1:num_iters],Jh);
disp(theta)