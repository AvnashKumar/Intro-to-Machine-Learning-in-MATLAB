clc;
clear all;
close all;
data=readtable("dataset.csv");

X = data{:, 1:5};
y = data{:, 6};
% using min max scalar
X_normalized = (X - min(X)) ./ (max(X) - min(X));
rng('default'); 
cv_split = 0.2;
idx = randperm(size(X_normalized, 1));
X_shuffled = X_normalized(idx, :);
y_shuffled = y(idx);

num_samples = size(X_shuffled, 1);
num_train = round(0.6 * num_samples); 
num_cv = round(0.2 * num_samples);
num_test = num_samples - num_train - num_cv;

X_train = X_shuffled(1:num_train, :);
y_train = y_shuffled(1:num_train);

X_cv = X_shuffled(num_train+1:num_train+num_cv, :);
y_cv = y_shuffled(num_train+1:num_train+num_cv);

X_test = X_shuffled(num_train+num_cv+1:end, :);
y_test = y_shuffled(num_train+num_cv+1:end);

lambda_values = [0, 0.01, 0.1, 1, 10, 100];

best_lambda = 0;
best_mse = Inf;

k = 5; % Number of folds for cross-validation
for lambda = lambda_values
    % Initialize an array to store cross-validation MSE values
    cv_mse_values = zeros(k, 1);
    
    % Perform k-fold cross-validation
    for fold = 1:k
        fold_size = num_train / k;
        cv_start = round((fold - 1) * fold_size) + 1;
        cv_end = round(fold * fold_size);
        
        X_train_fold = [X_train(1:cv_start-1, :); X_train(cv_end+1:end, :)];
        y_train_fold = [y_train(1:cv_start-1); y_train(cv_end+1:end)];
        X_val_fold = X_train(cv_start:cv_end, :);
        y_val_fold = y_train(cv_start:cv_end);
        
        % Calculate the linear regression coefficients with regularization
        X_train_fold_extended = [ones(size(X_train_fold, 1), 1), X_train_fold];
        beta = (X_train_fold_extended' * X_train_fold_extended + lambda * eye(size(X_train_fold_extended, 2))) \ (X_train_fold_extended' * y_train_fold);
        
        % Predict on the validation fold
        X_val_fold_extended = [ones(size(X_val_fold, 1), 1), X_val_fold];
        y_val_pred = X_val_fold_extended * beta;
        
        % Calculate the MSE for this fold
        cv_mse = mean((y_val_fold - y_val_pred).^2);
        cv_mse_values(fold) = cv_mse;
    end
    
    % Calculate the mean MSE over the k folds for this lambda
    mean_cv_mse = mean(cv_mse_values);
    
    % Check if this lambda gives a lower MSE than the current best
    if mean_cv_mse < best_mse
        best_mse = mean_cv_mse;
        best_lambda = lambda;
    end
    
    fprintf('Lambda: %.4f, Mean Cross-Validation MSE: %.4f\n', lambda, mean_cv_mse);
end

fprintf('Optimal Lambda: %.4f, Best Cross-Validation MSE: %.4f\n', best_lambda, best_mse);
