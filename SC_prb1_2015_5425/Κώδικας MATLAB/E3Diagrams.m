for i=[7:12]
    
    n=2.^[i];
    
    A= full(gallery('tridiag',n,rand(1),rand(1),rand(1))); %dhmiourgia tridiagwniwn mhtrwwn
    B= full(gallery('tridiag',n,rand(1),rand(1),rand(1)));
   
    f=@()myTridMult(A,B);
    T(5,i-6)= timeit(f);
    flops= 13*n-14; 
    F(5,i-6)= flops/T(5,i-6)*10^9;
    
end

n=2.^[7:12];

figure %Xronoi
plot(n,T(1,:),'g*--')
hold on
plot(n,T(2,:),'rx-')
hold on
plot(n,T(3,:),'bd:')
hold on
plot(n,T(4,:),'ys-.')
hold on
plot(n,T(5,:),'kh--')
hold off
legend('rand *','tridiag x','triau d','hess square','tridmult hexagramm')
title('Xronoi mult A,B me mtimes')
xlabel('matrix size')
ylabel('time (s)')

figure %Gflops
plot(n,F(1,:),'g*--')
hold on
plot(n,F(2,:),'rx-')
hold on
plot(n,F(3,:),'bd:')
hold on
plot(n,F(4,:),'ys-.')
hold on
plot(n,F(5,:),'kh--')
hold off
legend('rand *','tridiag x','triau d','hess square','tridmult hexagramm')
title('Epidosi mult A,B me mtimes')
xlabel('matrix size')
ylabel('Glops/s')