clc
clear all 
clc

%%From the cat dog images, the vectorization has been carried out and 1D
%%vector for an image has been obtained. Note, the same images used in
%%cat/dog classification has been used in this exercise as well.

%RBY-array size 20*20*3
load X.mat %both your cat and dog trainset has been saved in this variable
load y.mat %cat-1 dog-0 target variable
load X_test.mat %test variable
load cat_train.mat
load dog_train.mat
load cat_test.mat
load dog_test.mat

%%%Developing model using SVM
SVMModel = fitcsvm(X,y,'Standardize',true,'KernelFunction','rbf','KernelScale','auto');


%Predicting using the developed model on training set as well as test set
P1=predict(SVMModel,cat_train);
P2=predict(SVMModel,dog_train);
P3=predict(SVMModel,cat_test);
P4=predict(SVMModel,dog_test);
 
 %%%Calculating the accuracy. counting no of one's in the predicted output.
 E1=sum(P1)/length(P1) %all ones are added together
 E2=1-(sum(P2)/length(P2))
 E3=sum(P3)/length(P3)
 E4=1-(sum(P4)/length(P4))