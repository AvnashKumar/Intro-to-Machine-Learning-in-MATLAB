function y = knn(Xtrain,ytrain,k,Xtest)
%%% Xtest belongs to new data points for which we are trying to predict the
%%% output class
for i=1:1:length(Xtest)
    nx=Xtest(i,:);   %%%the one row value will be stored in nx;(new data point)
 
    for j=1:1:length(Xtrain)%%% eculidian distance of new data point with all existing dataset
     ed(j,1)=sqrt(sum(Xtrain(j,:)-nx).^2);
     ed(j,2)=ytrain(j);
    end
    ed_sort=sortrows(ed);%step-3: Arranging the euclidian data in descending order
    %sortrows will sort the first coulmn only in row wise
    for p=1:1:k %%%%step-4: Storing the value of output till k neighbour
        eds(p)=ed_sort(p,2);
    end
     count=nnz(eds);%%%% counting no of one's in k neighbour
     
     if count<round(k/2)%%% the condition is true only when count is less than 3 assuming k=5
         ypred=0;
     else %%% no of ones is higher than 3 so the new data belongs to y=1;
         ypred=1;
     end
     y(i,1)=ypred;
end