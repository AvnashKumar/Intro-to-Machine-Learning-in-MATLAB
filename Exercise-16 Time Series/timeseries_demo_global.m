clear all
close all
clc

load X.mat
xdate=X{:,1};
xv=X{:,2};
xv = xv(~isnan(xv))
%%%visulaising given data

plot(1:1:length(xv),xv,'r')
xlabel('Time')
ylabel('Temperature')
title('Temperature variation over the years')

 t=1:1:length(xdate);
y=xv;
yold=y
d_poly=3;
d_periodic=6;
T=365;
t=1:1:length(y)

[A,c]=lsfit_poly_periodic(t,y,d_poly,d_periodic,T)
 
% y = poly_periodic(t,c,d_poly,d_periodic, T)

m=length(t);
y=zeros(m,1);
c_poly=c(1:d_poly+1);
c_periodic=c(d_poly+2:end);
c_poly=c_poly'
for i=0:d_poly
    temp=t.^i
    y=y+temp'*c_poly(i+1)'
end
 for i=1:1:d_periodic
    y=y+cos((2*pi*i/T)*t)'*c_periodic(2*i-1)
    y=y+sin((2*pi*i/T)*t)'*c_periodic(2*i)
 end
figure
plot(t,yold,'r')
hold on
plot(1:1:m,y(1:m),'b*')
 xlabel('Time')
ylabel('Temperature')
title('Temperature variation over the years')
legend('Actual','Prediction')
 