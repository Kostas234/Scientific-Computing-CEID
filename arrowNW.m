%συνάρτηση arrowNW(T,n) που θα παίρνει για είσοδο το T και την τιμή του n
%και θα κατασκευάζει μητρώα A ∈ R mn×mn με μορφή ΒΔ βέλους βάσει του
%T και ενός μητρώου D = T + mI όπου I το ταυτοτικό μεγέθους m
function A = arrowNW(T,n)
%
m=length(T);
A=eye(n);
I=0;
for u=1:m
    I(u,u)=1;
end
D=T+m*I;
A=kron(A,D);
for i=2:n
    A1(1,i)=1;
    A1(i,i)=0;
    A2(i,1)=1;
    A2(i,i)=0;
end
A1=kron(A1,T);
A2=kron(A2,T);
A=A+A1+A2;
%
end
