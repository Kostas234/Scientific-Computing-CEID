myHash=9397;
rng(myHash);
s=0;
for n=[125 250]
for m=[8 16]
    s=s+1;
    if s>2
        m=m/2;
    end
    T=full(sprand(m,m,0.6));
%--------ARROW---------------
A=0;
for j=1:m*n
    A(j,j)=0;
end
m=length(T);
I=0;
for u=1:m
    I(u,u)=1;
end
D=T+m*I;
for i=1:m:m*n
    a=0;
    d=0;
    x=0;
    for l=i:i+m-1
        b=1;
        c=1;
        a=a+1;
        for q=i:i+m-1
            A(l,q)=D(a,b);
            b=b+1;
        end
        if l>=m+1
            d=d+1;
            for w=1:m
                A(l,w)=T(d,w);
            end
        end
        if l<m+1
            for f=m+1:m:m*n
                x=1;
                for h=f:f+m-1
                    A(l,h)=T(l,x);
                    x=x+1;
                end
            end       
        end
    end
end
%disp(n)
%disp(m)
%figure
%spy(A)
% Δημιουργια του μητρωου μεταθεσης W
k=1;
W=0;
W_T=0;
for i=length(A):-1:1
W(k,i)=1;
k=k+1;
end
% Το αναστροφο του W
W_T=reshape(W,length(W),[])';
e=ones(m*n,1);
b=A*e;
A2=W*A*W_T*W;
b2=W*b;
X=@() newt(A,b);
X2=@() newt(A2,b2);
tim=timeit(X);
fprintf('Για την επιλυση του Ax=b με n=%d και m=%d ο χρονος ειναι:%d\n', n,m,tim);
tim2=timeit(X2);
fprintf('Για την επιλυση του W*A*W_T*W*x=W*b με n=%d και m=%d ο χρονος ειναι:%d\n', n,m,tim2);
end
end