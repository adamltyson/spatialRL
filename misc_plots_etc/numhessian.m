function H=numhessian(f,x,dx)

N=length(x);
H=zeros(N,N);

dxv=zeros(size(x));

y=f(x);

for i=1:N
    dxvi=dxv;
    dxvi(i)=dx(i);
    yi=f(x+dxvi);
    
    for j=1:i
        dxvj=dxv;
        dxvj(j)=dx(j);
        yj=f(x+dxvj);
        
        yij=f(x+dxvi+dxvj);
        
        H(i,j)=(yij-yi-yj+y)/(dx(i)*dx(j));
        H(j,i)=H(i,j);
    end
end
