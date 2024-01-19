clc
clear 
close all

%Load the dataset and Scale the Features (min-max Scalar)
data = load('Data_clustering.csv');
features = data(:, 1:end-1);
min_values = min(features);
max_values = max(features);
scaled_features = (features - min_values) ./ (max_values - min_values);
X = [scaled_features, data(:, end)];


        % ELBOW METHOD
%======================================================%
%======================================================%
k = 5;  % number of clusters
% Finding optimal no. of clusters using the elbow method
wcss = zeros(10, 1); % Initialize an array for the within-cluster sum of squares
for k = 1:10
    [~,~,sumd] = kmeans(X, k);
    wcss(k) = sum(sumd); % Store the within-cluster sum of squares
end

% Plotting the elbow curve
figure;
plot(1:10, wcss, 'bo-');
title('Elbow Method for Optimal Cluster Number');
xlabel('Number of Clusters');
ylabel('Within-Cluster Sum of Squares (WCSS)');
opts = statset('Display','final');


       % K-MEANS CLUSTERING
%======================================================%
%======================================================%
[idxKmeans,C,sumd,D] = kmeans(X, k, 'Options', opts);

% Visualize K-Means Clustering
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, idxKmeans, 'filled');
title('K-Means Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(k));

% Calculate WCSS and BCSS for K-means
wcssKmeans = sum(sumd);
bcssKmeans = sum(pdist2(C,mean(X)).^2);

% Calculate Silhouette score
silhouetteKmeans = silhouette(X,idxKmeans);
silhouetteKmeans_avg = mean(silhouetteKmeans);

% Calculate DB index
dbIndexKmeans = DBIndexCalculation(X, idxKmeans);

% Display results
disp("K-means Clustering Results:")
disp("WCSS: " + wcssKmeans)
disp("BCSS: " + bcssKmeans)
disp("Silhouette Score: " + silhouetteKmeans_avg)
disp("DB Index: " + dbIndexKmeans)
fprintf('\n');
pause;


        % HIERARCHICAL CLUSTERING%
%======================================================%
%======================================================%
tree = linkage(X, 'average');
idxHierarchical = cluster(tree, 'maxclust', k);
Z = linkage(X, 'complete', 'euclidean'); % Replace with your preferred method and metric
% Display the dendrogram
figure
dendrogram(Z);
T = cluster(Z, 'MaxClust', k);
% 'T' contains cluster assignments for each data point
% Visualize the clustering results
figure
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, T, 'filled');
title('Hierarchical Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
colormap(jet(k)); 

% Calculate WCSS and BCSS for Hierarchical clustering
D = pdist(X);
wcssHierarchical = sum(D.^2);
bcssHierarchical = sum(pdist2(mean(X), X).^2);
silhouetteHierarchical = silhouette(X,idxHierarchical);
silhouetteHierarchical_avg = mean(silhouetteHierarchical);
dbIndexHierarchical = DBIndexCalculation(X, idxHierarchical);

%displaying results
disp("Hierarchical Clustering Results:")
disp("WCSS: " + wcssHierarchical)
disp("BCSS: " + bcssHierarchical)
disp("Silhouette Score: " + silhouetteHierarchical_avg)
disp("DB Index: " + dbIndexHierarchical)
fprintf('\n');


          % DB SCAN%
%======================================================%
%======================================================%

epsilon = 1;  % Maximum distance for neighbors
MinPts = 3;     % Minimum number of points in a cluster
idx_dbscan= dbscan(X, epsilon, MinPts);
figure;
%displaying results
scatter3(X(:, 1), X(:, 2), X(:, 3), 20, idx_dbscan, 'filled');
title('DBSCAN Clustering Results');
xlabel('Feature 1');
ylabel('Feature 2');
xlabel('Feature 3');
colormap(jet(max(idx_dbscan)));

%Calculating Evaluation Matrices
silhouette_dbscan = silhouette(X, idx_dbscan);
silhouette_dbscan_avg = mean(silhouette_dbscan);

% DB Index for DBSCAN
dbIndex_dbscan = DBIndexCalculation(X, idx_dbscan);
disp("DBSCAN Clustering Results:")
disp("Silhouette Score: " + silhouette_dbscan_avg)
disp("DB Index: " + dbIndex_dbscan)
fprintf('\n');


 % APPLYING PCA%
%======================================================%
%======================================================%

[coeff,score,latent,~,explained] = pca(X);

% Specify the number of principal components to use
numComponents = 2; % Number of principal components

% Reduce the Xset
dataReduced = score(:,1:numComponents);

% Rerun the clustering on the reduced dataset
k = 3;  % number of clusters
opts = statset('Display','final');
[idxPCA, C, sumd, D] = kmeans(dataReduced, k, 'Options', opts);

% Calculate WCSS and BCSS for PCA-enabled clustering
wcssPCA = sum(sumd);
bcssPCA = sum(pdist2(C,mean(dataReduced)).^2);

% Calculate Silhouette score for PCA-enabled clustering
silhouettePCA = silhouette(dataReduced,idxPCA);
silhouettePCA_avg = mean(silhouettePCA);

% Calculate DB index for PCA-enabled clustering
dbIndexPCA = DBIndexCalculation(dataReduced, idxPCA);

% Display results for PCA-enabled clustering
disp("PCA-Enabled Clustering Results:")
disp("WCSS: " + wcssPCA)
disp("BCSS: " + bcssPCA)
disp("Silhouette Score: " + silhouettePCA_avg)
disp("DB Index: " + dbIndexPCA)

