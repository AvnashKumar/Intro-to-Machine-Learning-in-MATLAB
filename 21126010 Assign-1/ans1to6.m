clc;
clear all;
close all;
data=readtable("dataset.csv");
data = data(randperm(size(data, 1)), :);

X = data{:, 1:5};
y = data{:, 6};
m = length(y)
X(1:10,:);
[X mu sigma] = featureNormalize(X);
X = [ones(m, 1) X];
X(1:10,:)
Xtrain= X(1:6000,:) ;
ytrain= y(1:6000,:);
Xcv= X(6001:8000,:) ;
ycv= y(6001:8000,:);
Xtest= X(8001:10000,:) ;
ytest= y(8001:10000,:);


fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.1;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(6, 1);
[theta, J_history] = gradientDescentMulti(Xtrain, ytrain, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);

sum(theta.^2)

fprintf('\n');
fprintf('Without Regularization error in training dataset: \n');

    fprintf(' %f \n', computeCostMulti(Xtrain, ytrain, theta));
fprintf('\n');
    fprintf('Without Regularization error in test dataset: \n');

    fprintf(' %f \n', computeCostMulti(Xtest, ytest, theta));
fprintf('\n');
        
