clc;
clear all;
close all;

% Step 1: Load and preprocess the data
data = readtable("Data_clustering.csv");
X = data{:, 1:6};
X = zscore(X); % Standardize the data

% Step 2: Determine the optimal number of clusters using the elbow method
wcss = zeros(10, 1); % Initialize an array for the within-cluster sum of squares
for k = 1:10
    [idx, ~, sumd] = kmeans(X, k);
    wcss(k) = sum(sumd); % Store the within-cluster sum of squares
end

% Plot the elbow curve
figure;
plot(1:10, wcss, 'bo-');
title('Elbow Method for Optimal Cluster Number');
xlabel('Number of Clusters');
ylabel('Within-Cluster Sum of Squares (WCSS)');

% Choose the optimal number of clusters (e.g., 3 based on the elbow method)

% Step 3: Perform different types of clustering
% Example: K-Means Clustering with the chosen optimal number of clusters
numClusters = 3; % Use the chosen optimal number of clusters
[idx_kmeans, centroids] = kmeans(X, numClusters);

% Calculate BCSS (Between-Cluster Sum of Squares)
TSS = sum(pdist(X).^2); % Total sum of squares
BCSS = TSS - wcss(numClusters); % Subtract WCSS for the chosen number of clusters

% Calculate Silhouette Score
silhouetteScore = mean(silhouette(X, idx_kmeans));

% Calculate Davies-Bouldin Index (DB Index)
dbIndex = DaviesBouldinIndex(X, idx_kmeans);

% Step 4: Evaluate and visualize the K-Means clustering results
% Visualize K-Means Clustering
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, idx_kmeans, 'filled');
title('K-Means Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(numClusters));

% Step 5: Apply PCA on the dataset
[coeff, score, latent] = pca(X);
reducedX = score(:, 1:3); % Reduce to the first three principal components

% Step 6: Rerun K-Means clustering on the PCA-enabled dataset
[idx_kmeans_pca, centroids_pca] = kmeans(reducedX, numClusters);

% Calculate BCSS (Between-Cluster Sum of Squares) for PCA-enabled clustering
TSS_pca = sum(pdist(reducedX).^2); % Total sum of squares
WCSS_pca = sum(pdist(reducedX, 'squaredeuclidean')); % WCSS for PCA-enabled clustering
BCSS_pca = TSS_pca - WCSS_pca;

% Calculate Silhouette Score for PCA-enabled clustering
silhouetteScore_pca = mean(silhouette(reducedX, idx_kmeans_pca));

% Calculate Davies-Bouldin Index (DB Index) for PCA-enabled clustering
dbIndex_pca = DaviesBouldinIndex(reducedX, idx_kmeans_pca);

% Step 7: Visualize the K-Means clustering results on the PCA-enabled dataset
figure;
scatter3(reducedX(:, 1), reducedX(:, 2), reducedX(:, 3), 20, idx_kmeans_pca, 'filled');
title('K-Means Clustering Results on PCA-Enabled Dataset');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
zlabel('Principal Component 3');
colormap(jet(numClusters));

% Step 8: Display or print the calculated metrics
disp(['BCSS (Original): ', num2str(BCSS)]);
disp(['Silhouette Score (Original): ', num2str(silhouetteScore)]);
disp(['DB Index (Original): ', num2str(dbIndex)]);
disp(['BCSS (PCA-Enabled): ', num2str(BCSS_pca)]);
disp(['Silhouette Score (PCA-Enabled): ', num2str(silhouetteScore_pca)]);
disp(['DB Index (PCA-Enabled): ', num2str(dbIndex_pca)]);

% Step 9: Define the Davies-Bouldin Index function
function dbIndex = DaviesBouldinIndex(data, labels)
    numClusters = max(labels);
    centroids = zeros(numClusters, size(data, 2));
    clusterSizes = zeros(1, numClusters);
    maxIntraClusterDistances = zeros(1, numClusters);

    for i = 1:numClusters
        clusterData = data(labels == i, :);
        clusterSizes(i) = size(clusterData, 1);
        centroids(i, :) = mean(clusterData);

        distances = pdist2(clusterData, clusterData);
        distances = distances + eye(clusterSizes(i)) * realmax;  % Avoid division by zero
        maxIntraClusterDistances(i) = max(mean(distances, 1));
    end

    dbIndex = 0;

    for i = 1:numClusters
        maxDB = -inf;
        for j = 1:numClusters
            if i ~= j
                db = (maxIntraClusterDistances(i) + maxIntraClusterDistances(j)) / norm(centroids(i, :) - centroids(j, :));
                if db > maxDB
                    maxDB = db;
                end
            end
        end
        dbIndex = dbIndex + maxDB;
    end

    dbIndex = dbIndex / numClusters;
end
