for i=7:12
    
    n=2.^i;
    A= triu(rand(n,n)); %dhmiourgia anw trigwnikwn mhtrwwn
    B= triu(rand(n,n));
    
    f=@()(A*B);
    T(3,i-6)= timeit(f);
    flops= 2*n^3-n^2;
    F(3,i-6)= flops/T(3,i-6)*10^9;
end
