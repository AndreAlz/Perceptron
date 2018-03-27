function MaW = entrenar2(Batch)
b=ones(1,7);%BIAS
teta=1;
MaW=zeros(63,7);%MATRIZ DE PESOS EN CERO
target=(eye(7)*2)-1;%MATRIZ INDETIDAD BIPOLAR
y=zeros(1,7);
load(Batch);
epoca=0;
stop=false;
while(stop==false)%COMPARAR SI LA MATRIZ A CAMBIADO
    epoca=epoca+1;
    stop=true;
    for i=1:28
        netinput=b+x(i,:)*MaW;%MATRIZ NET INPUT 1*7
        y(netinput>=teta)=1;
        y(-teta<netinput<teta)=0;
        y(netinput<=-teta)=-1;
        lugar=mod(i,7);
        if(lugar==0)
            lugar=7;
        end
        for j=1:7
            if (isequal(target(lugar,j),y(j))==0)%SI LA EL PRIMER5 TARGET ES DIFERENTE AL INPUT
                b(j)=b(j)+target(lugar,j);
                MaW(:,j)=MaW(:,j)+x(i,:)'*target(lugar,j);
                stop=false;
            end
        end
    end
end