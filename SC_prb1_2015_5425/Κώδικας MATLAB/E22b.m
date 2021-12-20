T3= zeros (6,10);
T4= zeros (6,10);
F3= zeros(6,10);
F4= zeros(6,10);
S= zeros (1,6);
for i= 7:12
    n=2.^i; 
    A= rand (n,n);
    B= rand (n,1);
    S(1,i-6)= n;
    for j= 1:10
        tic
        [L, U, P]=lu (A);
        T3(i-6,j)=toc;
        flops= (2/3)*n^3;
        F3(i-6,j)= flops/T3(i-6,j)*10^9;
    
        tic
        c= A*B;
        T4(i-6,j)=toc;
        flops= 2*n^2-n;
        F4(i-6,j)= flops/T4(i-6,j)*10^9;
        
    end
end

T3= (mean(T3,2))';
T4= (mean(T4,2))';
F3= (mean(F3,2))';
F4= (mean(F4,2))';

figure
plot(S,T3,'b*--')
hold on
plot(S,T4,'rx-')
hold off
legend('lu(A)','c=A*b')
title('Xronos 10 ektelesewn')
xlabel('matrix size')
ylabel('time(s)')

figure
plot(S,F3,'b*--')
hold on
plot(S,F4,'rx-')
hold off
legend('lu(A) *', 'c=A*b x')
title('Epidosi 10 ektelesewn')
xlabel('matrix size')
ylabel('Gflops/s')