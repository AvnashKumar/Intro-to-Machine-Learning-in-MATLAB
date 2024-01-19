function J = computeCostMulti(X, y, theta)

m = length(y); 

h=X*theta;
error=h-y;

J=(1/(2*m))*(sum(error.^2)+sum(theta.^2));

end
