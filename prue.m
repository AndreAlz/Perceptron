function x= prue()
mBatch=xlsread('prueba');
x=zeros(7,63);
k=1;
for j=1:7
 x(k,:)=reshape(mBatch(1:9,7*j-6:7*j),1,63);
 k=k+1;   
end
end
