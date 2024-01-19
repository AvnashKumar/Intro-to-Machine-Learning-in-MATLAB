function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)

m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    
   h=X*theta;
   m=length(h);
   error=(h-y);
   gradient=(1/m)*(X'*error);
   theta=theta-(alpha*gradient);

    J_history(iter) = computeCostMulti(X, y, theta);

end

end
