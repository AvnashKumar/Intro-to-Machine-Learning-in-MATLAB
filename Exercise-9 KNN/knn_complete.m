clear all
clc
close all

d=importdata('phonedata.txt');%%% use this command if the file contain text data

%%%%convert the text data into numbers.

 [m,n]=size(d.data)
 i=3
  for i=1:1:m
     a=d.textdata(i);
     b=char(a);
     len=length(b);
     if len==4 %%% it checks for male whose length is four
         X(i,1)=1;%male corresponds to one
     else
         X(i,1)=0;%female corresponds to zero
     end
 end
 X=[X d.data(:,1:2)]%%% Final feature matrix with all numerical data
 
 X=featureNormalize(X)%%% Normalising feature
 y=d.data(:,3);%%%%Target value
 Xtrain=X(1:360,:);
 ytrain=y(1:360);
 Xtest=X(361:end,:);
 ytest=y(361:end);

 %%%%%% KNN algorithm
% %step-1:Input no of k-neighbors
 k=3;
 %step-2: calculate euclidean distance for new data set (consider test data set as new points)
% %i=1;
 X=Xtrain;%%%Test data which has to be classified
 yactual=ytrain;%%%test data actual result
  ypred=knn(Xtrain,ytrain,k,X);%%%X belongs to new data set 
% %%%confusion matrix function
 [Cmatrix,ACC,P,R,F1]=confusionmatrix(ypred,yactual);
 Cmatrix
 ACC
 P
 R
 F1




