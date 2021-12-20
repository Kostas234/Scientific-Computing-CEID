for i=7:12
    
    n=2.^[i];

    A= full(gallery('tridiag',n,rand(1),rand(1),rand(1))); 
    B= full(gallery('tridiag',n,rand(1),rand(1),rand(1)));
    
    f=@()(A*B);
    C(1,i-6)= timeit(f);
    
    f=@()myTridMult(A,B);
    C(2,i-6)= timeit(f);

end

n=2.^[7:12];

figure %xronoi
plot(n,C(1,:),'b*--')
hold on
plot(n,C(2,:),'kx-')
hold off
legend('mtimes *','myTridMult x')
title('Sugkrish xronwn mtimes-myTridMult')
xlabel('matrix size')
ylabel('time (s)')