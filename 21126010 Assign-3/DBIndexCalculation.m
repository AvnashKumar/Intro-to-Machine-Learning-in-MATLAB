function dbIndex = DBIndexCalculation(data, idx)
    k = max(idx); % Number of clusters

    % Compute the scatter values for each cluster
    scatterVals = zeros(k, 1);
    for i = 1:k
        clusterData = data(idx == i, :);
        centroid = mean(clusterData);
        scatterVals(i) = mean(sqrt(sum((clusterData - centroid).^2, 2)));
    end

    % Compute the pairwise distance between cluster centroids
    centroidDistances = zeros(k);
    for i = 1:k
        for j = 1:k
            if i ~= j
                centroidDistances(i, j) = norm(mean(data(idx == i, :)) - mean(data(idx == j, :)));
            end
        end
    end

    % Compute the Davies-Bouldin Index
    R = zeros(k);
    for i = 1:k
        for j = 1:k
            if i ~= j
                R(i, j) = (scatterVals(i) + scatterVals(j)) / centroidDistances(i, j);
            end
        end
    end

    % Compute the DB index
    dbIndex = sum(max(R, [], 2)) / k;
end
