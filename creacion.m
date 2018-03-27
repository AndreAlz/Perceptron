function x = creacion(folder)
mainfolder=dir(folder);
x=zeros(28,63);
k=1;
for h=3:30
    i=imread(mainfolder(h).name);
    [i2,]=rgb2ind(i,2);
    ir=imresize(i2,[9,7]);
    d=double(ir);
    a=ones('like',d);
    y=-2*d+a;
    x(k,:)=reshape(y,1,63);
    k=k+1;
end
end