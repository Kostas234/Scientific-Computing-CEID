T1= zeros (1,6);
T2= zeros (1,6);
F1= zeros (1,6);
F2= zeros (1,6);
S= zeros (1,6);
for i= 7:12 
    n=2.^i;
    A= rand (n,n);
    B= rand (n,1);
    S(1,i-6)= n;
    tic
    [L, U, P]=lu (A);
    T1(1,i-6)=toc;
    flops= (2/3)*n^3;
    F1(1,i-6)= flops/T1(1,i-6)*10^9;
    
    tic
    c= A*B;
    T2(1,i-6)=toc;
    flops= 2*n^2-n;
    F2(1,i-6)=flops/T2(1,i-6)*10^9;

end

figure
plot(S,T1,'b*--')
hold on
plot(S,T2,'rx-')
hold off
legend('lu(A) *','c=A*b x')
title('Xronos mias ektelesis')
xlabel('matrix size')
ylabel('time(s)')

figure
plot(S,F1,'b*--')
hold on
plot(S,F2,'rx-')
hold off
legend('lu(A) *','c=A*b x')
title('Epidosi mias ektelesis')
xlabel('matrix size')
ylabel('Gflops/s')