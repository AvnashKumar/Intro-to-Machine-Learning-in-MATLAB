% Hirarchical Clustering
% 
clc
close all
%%% Read more: https://in.mathworks.com/help/stats/hierarchical-clustering.html
%%%%visualisation of data points%%%%
X = [1 2; 2.5 4.5; 2 2; 4 1.5; 4 2.5];
plot(X(:,1),X(:,2),'r*')
axis([0 5 0 5])

%%%%%Finding dissimilarity matrix: pdist command is used
Y=pdist(X)
squareform(pdist(X))
pause
%%%Cluster the datapoints based on the type of linkage
%Read more about linkages: https://in.mathworks.com/help/stats/linkage.html
Z=linkage(Y)
pause

%Z=linkage(Y,'complete')
%Z=linkage(meas,'average','cityblock');

%In this output, each row identifies a link between objects or clusters.
%The first two columns identify the objects that have been linked. 
%The third column contains the distance between these objects.
%For the sample data set of x- and y-coordinates, the linkage function
%begins by grouping objects 4 and 5, which have the closest proximity
%(distance value = 1.0000)

%%Draw the dendogram
%%%%Read more: https://in.mathworks.com/help/stats/dendrogram.html
tree=dendrogram(Z)

%%%Make clusters by selecting number of clusters
T = cluster(Z,"maxclust",2)% two clusters will be created
T = cluster(Z,"maxclust",3)% three clusters will be created


