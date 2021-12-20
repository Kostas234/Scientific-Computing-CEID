for i=[7:12]
    
    n= 2.^[i];
    
    u= rand(n,1);
    v= rand(n,1);
    b= rand(n,1);
    
    f=@() rank2_power(u,v,b);
    T(1,i-6)= timeit(f);
    flops= 18*n^3 -4*n^2-n;
    F(1,i-6)= flops/T(1,i-6)*10^9;
    
    f=@() my_rank2_power(u,v,b);
    T(2,i-6)= timeit(f);
    flops= 23*n^2 -10*n;
    F(2,i-6)= flops/T(2,i-6)*10^9;
    
end

n=2.^[7:12];

figure %Xronoi
plot(n,T(1,:),'bx--')
hold on
plot(n,T(2,:),'k*-')
hold off
legend('rank2power x', 'myrank2power *')
title('Xronoi ekteleshs twn dyo function')
xlabel('matrix size')
ylabel('time (s)')

figure %Epidosi
plot(n,F(1,:),'bx--')
hold on
plot(n,F(2,:),'k*-')
hold off
legend('rank2power x','myrank2power *')
title('Epidosi ekteleshs twn dyo function')
xlabel('matrix size')
ylabel('Glops/s')
