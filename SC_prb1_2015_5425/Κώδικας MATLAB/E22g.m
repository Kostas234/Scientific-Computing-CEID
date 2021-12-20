T5= zeros (1,6);
T6= zeros (1,6);
F5= zeros (1,6);
F6= zeros (1,6);
S= zeros (1,6);
for i= 7:12 
    n=2.^i;
    A= rand (n,n);
    B= rand (n,1);
    S(1,i-6)= n;
    
    f1=@()lu (A);
    T5(1,i-6)=timeit(f1);
    flops= (2/3)*n^3;
    F5(1,i-6)= flops/T5(1,i-6)*10^9;
    
    f2=@() (A*B);
    T6(1,i-6)=timeit(f2);
    flops= 2*n^2-n;
    F6(1,i-6)=flops/T6(1,i-6)*10^9;

end

figure
plot(S,T5,'b*--')
hold on
plot(S,T6,'rx-')
hold off
legend('lu(A) *','c=A*b x')
title('Xronos me timeit')
xlabel('matrix size')
ylabel('time(s)')

figure
plot(S,F5,'b*--')
hold on
plot(S,F6,'rx-')
hold off
legend('lu(A) *','c=A*b x')
title('Epidosi me timeit')
xlabel('matrix size')
ylabel('Gflops/s')