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
Y_actual=data(:,2);
Y_pridict=X*theta';

RSS= sum((Y_pridict-Y_actual).^2);
yavg=mean(Y_actual);
TSS=sum((yavg-Y_actual).^2);
Rsquare= 1-(RSS/TSS);

%Residual sum of square Errors
disp(['Residual sum of square Errors is: ' num2str(RSS)]);
disp(['Total sum of squres is: ' num2str(RSS)]);

fprintf(['The R squred value is: ' num2str(Rsquare)]);
fprintf("\nProgram End..");


