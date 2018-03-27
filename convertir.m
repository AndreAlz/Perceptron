function letraM = convertir(img)
    i=imread(img);
    [i2,]=rgb2ind(i,2);
    ir=imresize(i2,[9,7]);
    x=double(ir);
    a=ones('like',x);
    y=-2*x+a;
    letraM=reshape(y,1,63);
end