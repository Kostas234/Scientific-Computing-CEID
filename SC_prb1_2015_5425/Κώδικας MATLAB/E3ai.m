for i=7:12
    
    n=2.^i;
    A=rand(n,n);
    B=rand(n,n);
    
    f=@()(A*B);
    T(1,i-6)=timeit(f);
    flops= 2*n^3-n^2;
    F(1,i-6)= flops/T(1,i-6)*10^9;
end