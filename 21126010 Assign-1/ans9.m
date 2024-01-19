clc;
clear all;
close all;
data=readtable("dataset.csv");

% Split the dataset into features (X) and the target variable (y)
X = data{:, 1:5};
y = data{:, 6};
% using min max scalar
X_normalized = (X - min(X)) ./ (max(X) - min(X));
rng('default'); % For reproducibility
cv_split = 0.2; 

% Randomly shuffle the data
idx = randperm(size(X_normalized, 1));
X_shuffled = X_normalized(idx, :);
y_shuffled = y(idx);

% Calculate the sizes for each set
num_samples = size(X_shuffled, 1);
num_train = round(0.6 * num_samples);
num_cv = round(0.2 * num_samples);
num_test = num_samples - num_train - num_cv;

% Split the data
X_train = X_shuffled(1:num_train, :);
y_train = y_shuffled(1:num_train);

X_cv = X_shuffled(num_train+1:num_train+num_cv, :);
y_cv = y_shuffled(num_train+1:num_train+num_cv);

X_test = X_shuffled(num_train+num_cv+1:end, :);
y_test = y_shuffled(num_train+num_cv+1:end);

lambda = 0.01; 
X_train_extended = [ones(num_train, 1), X_train];
beta = (X_train_extended' * X_train_extended + lambda * eye(size(X_train_extended, 2))) \ (X_train_extended' * y_train);

y_train_pred = X_train_extended * beta;

mse_train = mean((y_train - y_train_pred).^2);

fprintf('Mean Squared Error (MSE) on Training Data: %.4f\n', mse_train);

X_test_extended = [ones(size(X_test, 1), 1), X_test];
y_test_pred = X_test_extended * beta;

mse_test = mean((y_test - y_test_pred).^2);
fprintf('Mean Squared Error (MSE) on Test Data: %.4f\n', mse_test);
