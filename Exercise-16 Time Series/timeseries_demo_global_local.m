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
y1=zeros(m,1);
c_poly=c(1:d_poly+1);
c_periodic=c(d_poly+2:end);
c_poly=c_poly'
for i=0:d_poly
    temp=t.^i;
    y1=y1+temp'*c_poly(i+1)';
end
 for i=1:1:d_periodic
    y1=y1+cos((2*pi*i/T)*t)'*c_periodic(2*i-1);
    y1=y1+sin((2*pi*i/T)*t)'*c_periodic(2*i);
 end
figure
plot(t,yold,'r')
hold on
plot(1:1:m,y1(1:m),'b*')
 xlabel('Time')
ylabel('Temperature')
title('Temperature variation over the years')
legend('Actual','Prediction')
 
%%%%Identifying resuide part

ynew=yold-y1 %y1 is the predicted value of trend+seasonality model

figure
plot(1:1:m,ynew,'r')

%%%performing stationality test in residue to identify noise

% %Adf test (null hypothesis is not stationary)
 adf_test=adftest(ynew)
% 
% %kpss test (null hypothesis is stationary)
 kpss_test=kpsstest(ynew)
   figure 
 parcorr(ynew)
 figure 
 autocorr(ynew)
% 
%local model
  Mdl1=arima(2,0,1) %defining the model
  md=estimate(Mdl1,ynew) % estimating parameters
  ylocal = infer(md,ynew); %output vlaues
%  
  ylast = ynew-ylocal %residue noise
  
   kp=kpsstest(ylast)
  ad=adftest(ylast)
%  
% %  %ylast=simulate(md,m)
% %     figure
% % %  plot(t,ylast,'r')
% % %   hold on
% %   plot(1:1:m,ylast,'b*')
%   
%   
%    figure 
%  autocorr(ylast)
% % 
%    figure
%   parcorr(ylast)
%  
 
%  
  yfinal=y1+ylocal;
  figure
  plot(t,y,'r')
     hold on
    plot(1:1:m,yfinal,'b*')
%   
%   
