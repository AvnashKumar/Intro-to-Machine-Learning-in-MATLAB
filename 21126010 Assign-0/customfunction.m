function m=customfunction(a)
m= -1*ones(100,2);
m(:,1)=(1:100);

for i=1:1:20
    m(a(i),2)=m(a(i),2)+1;

end
    
    m((m(:,2)==-1),:)=[];
     
end