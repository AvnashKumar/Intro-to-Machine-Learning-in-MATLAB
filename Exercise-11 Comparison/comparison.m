clear all
close all
clc

%%%load the phone data

d=importdata('phonedata.txt')%%% use this command if the file contain text data

%%%%convert the text data into numbers.

 [m,n]=size(d.data);

  for i=1:1:m
     a=d.textdata(i);
     b=char(a)   ;  
     len=length(b);
     if len==4 %%% it checks for male whose length is four
         X(i,1)=1;%male corresponds to one
     else
         X(i,1)=0;%female corresponds to zero
     end
 end
 X=[X d.data(:,1:2)]%%% Final feature matrix with all numerical data
 
 X=featureNormalize(X);%%% Normalising feature
 y=d.data(:,3);%%%%Target value
 Xtrain=X(1:360,:);
 ytrain=y(1:360);
 Xtest=X(361:end,:);
 ytest=y(361:end);
 
 %%%%%%%%%%Logistic regression without regularization%%%%%%%%%%%%%%
 
 %  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(Xtrain);

% Add intercept term to x and X_test
X = [ones(m, 1) Xtrain];
y=ytrain;
% Initialize fitting parameters
initial_theta = zeros(size(X, 2), 1);

% Compute and display initial cost and gradient
[cost, grad] = costFunction(initial_theta, X, y);
%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

%%%%optimised value of theta
theta


% Compute accuracy on our training set
[m1, n1] = size(Xtest);
Xt=[ones(m1, 1) Xtest];
p = predict_1(theta, Xt);
 [Cmatrix,ACC,P,R,F1]=confusionmatrix(p,ytest);

 fprintf('F1 Score using logistic regression without regularization\n');
 Cmatrix
 F1
%%%%%%%%%%%%%%%%%%Logistic regression with regularization
% Set regularization parameter lambda to 1
lambda = 10;
initial_theta = zeros(size(X, 2), 1);
% Compute and display initial cost and gradient for regularized logistic
% regression
[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

%%%%optimised value of theta
theta;



% Compute accuracy on our training set
p = predict_1(theta, Xt);
 [Cmatrix,ACC,P,R,F1]=confusionmatrix(p,ytest);
 
 fprintf('F1 Score using logistic regression with regularization\n');
% Cmatrix
 F1
 

% %%%%%%%%%%%%%%%%learning curve for linear regression
% initial_theta = zeros(size(X, 2), 1);
% lambda = 0;
% [error_train, error_val] = ...
%     learningCurve(X, y, ...
%                   Xt, ytest, ...
%                   lambda);
% 
% plot(1:m, error_train, 1:m, error_val);
% title('Learning curve for linear regression')
% legend('Train', 'Cross Validation')
% xlabel('Number of training examples')
% ylabel('Error')
% fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
% for i = 1:m
%     fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
% end
% % % 
% % %%%%%%%%%Validation curve to find the optimal value of lambda%%%%%%%%%%%%%%%%
% 

%%%%%%%%%%%%%%%Support vector machines%%%%%%%%%%%%%%%%%%%%%%
%%%%Make sure first column is not 1 which is needed in logistic regression.
SVMModel = fitcsvm(Xtrain,ytrain,'Standardize',true,'KernelFunction','rbf','KernelScale','auto');
P1=predict(SVMModel,Xtest);
[Cmatrix,ACC,P,R,F1]=confusionmatrix(P1,ytest);
 
 fprintf('F1 Score using Support vector machines\n');
 %Cmatrix
 F1
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%       K-Nearest Neighbor           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%Make sure first column is not 1 which is needed in logistic regression.
 k=5;
 ypred=knn(Xtrain,ytrain,k,Xtest);
 [Cmatrix,ACC,P,R,F1]=confusionmatrix(ypred,ytest);
 fprintf('F1 Score using KNN\n');
 %Cmatrix
 F1

   
