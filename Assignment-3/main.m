clc;
clear all;
close all;
data=readtable("Data_clustering.csv");
features = data(:, 1:end-1);

% Compute the minimum and maximum values for each feature
min_values = min(features);
max_values = max(features);

% Perform Min-Max scaling for each feature
scaled_features = (features - min_values) ./ (max_values - min_values);

% Combine scaled features with the labels (assuming the last column is the label)
data = [scaled_features, data(:, end)]
X = data{:, 1:6};
% Preprocess your data (scaling, handling missing values, etc.)
% For example, you can use the 'zscore' function to standardize your data.
% Preprocess your data (scaling, handling missing values, etc.)
% For example, you can use the 'zscore' function to standardize your data.
X = zscore(X);

% Perform hierarchical clustering using your chosen method and distance metric
Z = linkage(X, 'complete', 'euclidean'); % Replace with your preferred method and metric

% Display the dendrogram
dendrogram(Z);

% Determine the number of clusters (e.g., by cutting the dendrogram)
% For example, let's cut the dendrogram into 3 clusters
T = cluster(Z, 'MaxClust', 3);

% 'T' contains cluster assignments for each data point

% Visualize the clustering results
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, T, 'filled');
title('Hierarchical Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(3));  % Use a suitable colormap

% You can further analyze and interpret your clustering results as needed
pause
% Define the number of clusters (e.g., 3 clusters)
numClusters = 3;

% Perform k-means clustering
[idx, centroids] = kmeans(X, numClusters);

% 'idx' contains cluster assignments for each data point
% 'centroids' contains the cluster centroids

% Visualize the clustering results
% Modify the visualization based on the number of features and clustering needs
% You can choose to visualize a subset of features if necessary
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, T, 'filled');
title('Hierarchical Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(3)); % Use a suitable colormap

pause;
% Define the parameters for DBSCAN
           
epsilon = 0.5;  % Maximum distance for neighbors
MinPts = 5;     % Minimum number of points in a cluster

% Perform DBSCAN clustering using the 'DBSCAN' toolbox
idx = dbscan(X, epsilon, MinPts);

% Visualize the results
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, idx, 'filled');
title('DBSCAN Clustering Results with Three Features');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(3)); % Use a suitable colormap
