for i=7:12
    
    n=2.^i;
    A= hess(rand(n,n)); %dhmiourgia mhtrwwn anw Hessenberg
    B= hess(rand(n,n));
    
    f=@()(A*B);
    T(4,i-6)= timeit(f);
    flops= 2*n^3-n^2;
    F(4,i-6)= flops/T(4,i-6)*10^9;
end
