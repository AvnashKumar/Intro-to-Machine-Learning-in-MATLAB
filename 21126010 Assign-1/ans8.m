clc;
clear all;
close all;
data=readtable("dataset.csv");

% Split the dataset into features (X) and the target variable (y)
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
num_train = round(0.6 * num_samples); % Define num_train based on your training size
num_cv = round(0.2 * num_samples);
num_test = num_samples - num_train - num_cv;

% Split the data
X_train = X_shuffled(1:num_train, :);
y_train = y_shuffled(1:num_train);

X_cv = X_shuffled(num_train+1:num_train+num_cv, :);
y_cv = y_shuffled(num_train+1:num_train+num_cv);

X_test = X_shuffled(num_train+num_cv+1:end, :);
y_test = y_shuffled(num_train+num_cv+1:end);

lambda_values = logspace(-5, 5, 100); 

r2_values = zeros(size(lambda_values));

X_train_extended = [ones(num_train, 1), X_train];
beta_baseline = (X_train_extended' * X_train_extended) \ (X_train_extended' * y_train);
y_train_pred_baseline = X_train_extended * beta_baseline;
baseline_r2 = 1 - sum((y_train - y_train_pred_baseline).^2) / sum((y_train - mean(y_train)).^2);

for i = 1:length(lambda_values)
    lambda = lambda_values(i);
    
    X_train_extended = [ones(num_train, 1), X_train];
    beta = (X_train_extended' * X_train_extended + lambda * eye(size(X_train_extended, 2))) \ (X_train_extended' * y_train);
    
    y_train_pred = X_train_extended * beta;
    
    r2 = 1 - sum((y_train - y_train_pred).^2) / sum((y_train - mean(y_train)).^2);
    
    r2_values(i) = r2;
end

% Plot lambda vs. R-squared
figure;
semilogx(lambda_values, r2_values, '-b', 'LineWidth', 2);
xlabel('Lambda');
ylabel('R-squared (R2) Value');
title('Lambda vs. R-squared (R2) for Regularization');
grid on;

best_lambda = lambda_values(r2_values == max(r2_values));
fprintf('Best Lambda: %.6f, Best R-squared (R2) Value: %.4f\n', best_lambda, max(r2_values));
