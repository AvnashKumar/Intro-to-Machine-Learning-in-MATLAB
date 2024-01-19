%Answer - 5

clc
clear all
close all

x=input('Enter a vector to sort : ');
disp("Your Entered Vector is : ");
disp(x);
n=numel(x);
it=1;
for i=1:n
    for j=1:(n-1)
        if x(1,j) > x(1,j+1)
            temp=x(1,j);
            x(1,j)=x(1,j+1);
            x(1,j+1)=temp;
        end
        disp(['After iteration ', num2str(it), ' Vector is: ']);
        disp(x);
        it=it+1;
    end
end
disp('Finally The Sorted Vector is : ');
disp(x);
    