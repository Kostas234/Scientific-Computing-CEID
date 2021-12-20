for i=7:12
    
    n=2.^i;
    A= full(gallery('tridiag',n,rand(1),rand(1),rand(1))); %dhmiourgia tridiagwniwn mhtrwwn
    B= full(gallery('tridiag',n,rand(1),rand(1),rand(1)));
    
    f=@()(A*B);
    T(2,i-6)=timeit(f);
    flops= 2*n^3-n^2;
    F(2,i-6)= flops/T(2,i-6)*10^9;
end
    