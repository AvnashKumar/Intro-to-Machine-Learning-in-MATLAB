% Hirarchical Clustering
% 
clc
close all
%%% Read more: 
%%%https://in.mathworks.com/help/stats/dbscan.html

%%%%visualisation of data points%%%%
% Parameters for data generation
N = 300;  % Number of data points
r1 = 0.5; % Radius of first circle
r2 = 5;   % Radius of second circle
theta = linspace(0,2*pi,N)';

X1 = r1*[cos(theta),sin(theta)]+ rand(N,1); 
X2 = r2*[cos(theta),sin(theta)]+ rand(N,1);
X = [X1;X2] % Noisy 2-D circular data set
scatter(X(:,1),X(:,2))

pause
%%%%%Finding dissimilarity matrix: pdist command is used
idx = dbscan(X,1,5); % The default distance metric is Euclidean distance
%Visualize the clustering.

gscatter(X(:,1),X(:,2),idx);
title('DBSCAN Using Euclidean Distance Metric')
