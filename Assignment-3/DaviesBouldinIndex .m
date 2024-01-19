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
