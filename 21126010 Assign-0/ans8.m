%Answer-8

clc
close all
clear all
a=randi([1 100],1,20);


m=customfunction(a);

disp('Number-No. of times repeated');
disp(m);

x=m(:,1);
y=m(:,2);
avg=mean(y);
avg_line= avg* ones(size(x));

figure
plot(x,y);
xlabel('Number');
ylabel('No. of repetition');

figure
plot(x(rem(x,2)==0),y(rem(x,2)==0),'dr')

hold on
plot(x(rem(x,2) ~=0), y(rem(x,2) ~=0),'og')
legend('even','odd');

hold on
xlabel('Number');
ylabel('No. of repetition');

plot(x,avg_line,'--b');