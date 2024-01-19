function [ CON,A,P, R, F1 ] = confusionmatrix(ypred,yactual)

 a=0;
 b=0;
 c=0;
 d=0;
 for i=1:1:length(ypred)
 if(isequal(ypred(i),yactual(i)))%%% this condition corresponds to true positives and true negatives
     if ypred(i)==1%%% this condition corresponds to actual=1 and predict=1 (true positive)
        a=a+1;
     else %%% this condition corresponds to actual=0 and predict=0 (true negative)
         b=b+1; 
     end
 else %%%% 
     if ypred(i)==1%%% this condition corresponds to actual=0 and predict=1 (False positive)
        c=c+1;
     else %%% this condition corresponds to actual=1 and predict=0 (False negative)
         d=d+1; 
     end
 end
 end
CON=[a c; d b];%%%confusion matrix
A=((a+b)/(a+b+c+d))*100; %%%% percentage predicted correctly
P=a/(a+c); %% precision=true positive/predicted positive
R=a/(a+d); %% recall=true positive/actual positive
F1=2*P*R/(P+R);%%% F1 socre
end


