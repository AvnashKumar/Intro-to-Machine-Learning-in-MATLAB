% Answer-4 

clc
close all
clear all
a=rand(3);
a(1,:)=10;

%displaying matrix
disp('The Matrix is: ');
disp(a);

determinant=det(a);
disp('The determinant of Matrix: ');
disp(determinant);