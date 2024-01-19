function [A,c_ls]= lsfit_poly_periodic(t,y,d_poly,d_periodic,T)

m=length(y)
%%%construct A matrix for polynomial part

Apoly=zeros(m,d_poly+1);

for i=0:1:d_poly
    Apoly(:,i+1)=t.^i;
end

%%%construct A matrix for periodic part

Aperiodic=zeros(m,2*d_periodic)

for i=1:1:d_periodic
    Aperiodic(:,2*i-1)=cos((2*pi*i/T)*t);
    Aperiodic(:,2*i)=sin((2*pi*i/T)*t);
end

A=[Apoly Aperiodic] 

lc=pinv(A)
c_ls=lc*y

end