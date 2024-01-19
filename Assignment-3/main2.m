clc;
clear all;
close all;

% Step 1: Load and preprocess the data
data = readtable("Data_clustering.csv");
X = data{:, 1:6};
X = zscore(X); % Standardize the data

% Step 2: Determine the optimal number of clusters
% You can use different methods to find the optimal number of clusters, such as the elbow method, silhouette analysis, or others.

% Example using the elbow method
wcss = zeros(10, 1); % Initialize an array for the within-cluster sum of squares
for k = 1:10
    [~,~,sumd] = kmeans(X, k);
    wcss(k) = sum(sumd) % Store the within-cluster sum of squares
end

% Plot the elbow curve
figure;
plot(1:10, wcss, 'bo-');
title('Elbow Method for Optimal Cluster Number');
xlabel('Number of Clusters');
ylabel('Within-Cluster Sum of Squares (WCSS)');
pause
% You can manually inspect the plot to determine the optimal number of clusters

% Step 3: Perform different types of clustering
% You can try hierarchical, k-means, DBSCAN, etc., with the chosen number of clusters

% Example: Hierarchical Clustering
Z = linkage(X, 'complete', 'euclidean');
dendrogram(Z);
T_hierarchical = cluster(Z, 'MaxClust', 3);

% Example: K-Means Clustering
numClusters = 3; % Use the chosen optimal number of clusters
[idx_kmeans, centroids] = kmeans(X, numClusters);

% Example: DBSCAN
epsilon = 1;  % Maximum distance for neighbors
MinPts = 3;     % Minimum number of points in a cluster
idx_dbscan= dbscan(X, epsilon, MinPts);


% Step 4: Evaluate and visualize the results
% You can evaluate the results using appropriate metrics and visualize the clusters

% Visualize Hierarchical Clustering
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, T_hierarchical, 'filled');
title('Hierarchical Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(3)); % Use a suitable colormap

% Visualize K-Means Clustering
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, idx_kmeans, 'filled');
title('K-Means Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(numClusters));

% Visualize DBSCAN Clustering
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, idx_dbscan, 'filled');
title('DBSCAN Clustering Results');

xlabel('Feature 1');
ylabel('Feature 2');
xlabel('Feature 3');


colormap(jet(max(idx_dbscan))); % Adjust the colormap based on the number of clusters

% You can also calculate and display clustering evaluation metrics as needed
