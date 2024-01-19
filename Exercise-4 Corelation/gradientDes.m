function [theta Jh]= gradientDes(X, y, theta, alpha, num_iters)



for iter = 1:num_iters
   h=X*theta;
   m=length(h);
   error=(h-y);
   gradient=(1/m)*(X'*error);
   theta=theta-(alpha*gradient);
      Jh(iter) = ComputeCost(X, y, theta);
 
end

end
