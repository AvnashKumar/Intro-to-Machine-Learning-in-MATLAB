function J=computeCost(X, y, theta)
h=X*theta;
error=h-y;
m=length(y);
J=(1/(2*m))*sum(error.^2);