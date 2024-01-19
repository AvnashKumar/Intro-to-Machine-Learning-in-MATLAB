% Answer-10 

clc
clear all
close all
fig1=imread('fig1.jpeg');
os=size(fig1)
pause
figure
imshow(fig1)
pause

%reducing size to half
fig2=imresize(fig1,0.5);
size(fig2)
figure
imshow(fig2)
pause

%10.2 convertig to greaay scale image
fig3=rgb2gray(fig1);
figure
imshow(fig3)
graysize=size(fig3)
pause

%10.3 one dimensional pixel
a=reshape(fig3,1,os(1)*os(2));
size_a=size(a)

%10.4 1D array to grayscale
fig4=reshape(a,[graysize(1),graysize(2)]);
fig4size= size(fig4)
figure
imshow(fig4)
pause

% 10.5 gray scale to colored
fig5 = cat(3, fig4, fig4, fig4);
fig5size = size(fig5);

figure
imshow(fig5)