% Answer - 3
clc
close all
clear all

n=input('Enter the value of n: ');
a=rand(n);
a(1,:)=10;
disp('The required Matrix is:');
disp(a);