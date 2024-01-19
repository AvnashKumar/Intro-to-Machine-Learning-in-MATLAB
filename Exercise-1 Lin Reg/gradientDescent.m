
function theta = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha




for i=1:num_iters
    h=X*theta;
    m=length(h);
    error=h-y;

    theta = theta - (alpha / m) * (X' * error);

    % theta0=(alpha/m)*sum(error);
    % theta1=(alpha/m)*sum(X'*(error));
    % theta(1,1)=theta(1,1)-theta0;
    % theta(2,1)=theta(2,1)-theta1;
end


