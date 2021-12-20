%% Ασκηση 1
%
%% 2.
%
%% (α')
%
for n=[128 512]
for t=[1 2 10]
A=rand(n);
rank=SMW(A,n,t);
disp(rank);
end
end
%
%% (β')
%
for n=[128 512]
for t=[1 2 10]
A=tril(randn(n));
rank=SMW(A,n,t);
disp(rank);
end
end
%
%% (γ')
%
% Για το μητρωο A=gep(rand(n))
for n=[128 512]
for t=[1 2 10]
A=gep(randn(n));
rank=SMW(A,n,t);
disp(rank);
end
end
% Για το μητρωο Α=triu(rand(n)))
for n=[128 512]
for t=[1 2 10]
A=triu(rand(n));
rank=SMW(A,n,t);
disp(rank);
end
end
%
%% (δ')
%
for n=[128 512]
for t=[1 2 10]
A=gfpp(n);
rank=SMW(A,n,t);
disp(rank);
end
end
%
%% 3.
%
n=5;
A=randn(n);
[L,U]=luboost(A);
%
%% ΜΕΡΟΣ Β
% 1.
% Παρακατω ο κωδικας που περιεχεται μεσα στην συναρτηση itref_double
% Δηλωση της συναρτησης:function [k,err]= itref_double(A,W,H,b)
%
H_T=reshape(H,length(H),[])';
A=double(A + W*H_T);
b=double(b);
x=double((A^(-1))*b);
k=1;
% Αρχικοποιηση της συνθηκης της while ωστε 
% να τρεξει τουλαχιστον μια φορα
err=10e-5;
while err>10e-6 %repeat
x1=double(x);
r=double(b-A*x);
z=double((A^(-1))*r);
x=double(x+z);
err=norm(x-x1,inf)/norm(x1,inf);
k=k+1;
% Αν το σφαλμα δεν γινεται μικροτερο απο την επιθυμητη τιμη
% επιστρεφει το αναλογο μηνυμα
if k>realmax
    disp('Αστοχία επαρκούς σύγκλισης');
end
end %until
%end της συναρτησης
%
%% 3.
for n=[10 100 1000]
for h=2:4
W=randn(n,1);
W=W/norm(W);
H=W(n:-1:1);
A=toeplitz([h,-1,zeros(1,n-2)]);
% Δοκιμη με τυχαιο b
b = randn(n,1);
[k,err]=itref_double(A,W,H,b);
tm=@() itref_double(A,W,H,b);
% Υπολογισμος χρονου συγκλισης
t=timeit(tm);
%
fprintf('Για n=%d και h=%d οι επαναληψεις ειναι: %d ',n,h,k);
fprintf('και ο χρονος συγκλισης:%d\n',t);
end
end
%
%
%% ΜΕΡΟΣ Γ
%
% 1.
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
    A=arrowNW(T,n);
end
end
%
%% 2.
%
m=4;
n=20;
T=full(sprand(m,m,0.6));
A=arrowNW(T,n);
%Απεικονιση του Α
figure
spy(A);
%
% 3.
%
[L,U]=lu(A);
figure
spy(L);
figure
spy(U);
%
% 4.
%
nnz(A);
nnz(L);
nnz(U);
fill_A=(nnz(L) + nnz(U )-m*n)/nnz(A);
%
% 5.
%
% Δημιουργια του μητρωου μεταθεσης W
W=0;
W_T=0;
k=1;
for i=length(A):-1:1
W(k,i)=1;
k=k+1;
end
% Το αναστροφο του W
W_T=reshape(W,length(W),[])';
%
% Πολλαπλασιασμος των προηγουμενων 2 μητρωων με το Α ωστε να ερθει σε
% μορφη ΝΑ βελους
B=W*A*W_T;
figure
spy(B);
[L,U]=lu(B);
figure
spy(L);
figure
spy(U);
fill_B=(nnz(L) + nnz(U )-m*n)/nnz(B);
%
%% 6.
%
s=0;
for n=[125 250]
for m=[8 16]
    s=s+1;
    if s>2
        m=m/2;
    end
    T=full(sprand(m,m,0.6));
    A=arrowNW(T,n);
W=0;
W_T=0;
t1=0;
t2=0;
tim=0;
tim2=0;
% Δημιουργια του μητρωου μεταθεσης W
k=1;
for i=length(A):-1:1
W(k,i)=1;
k=k+1;
end
% Το αναστροφο του W
W_T=reshape(W,length(W),[])';
e=ones(m*n,1);
b=A*e;
B=W*A*W_T;
% Υπολογισμος χρονου επιλυσης και σχετικου σφαλματος
% για τις δυο περιπτωσεις
x1=newt(A,b);
x2=newt(B*W,W*b);
t1=@() newt(A,b);
t2=@() newt(B*W,W*b);
tim=timeit(t1);
f_1=(norm(e-x1,inf))/norm(e,inf);
fprintf('-(n=%d,m=%d):\nΓια την επιλυση του Ax=b ο χρονος ειναι:%d και το σφαλμα:%d\n\n', n,m,tim,f_1);
tim2=timeit(t2);
f_2=(norm(e-x2,inf))/norm(e,inf);
fprintf('-(n=%d,m=%d):\nΓια την επιλυση του W*A*W_T*W*x=W*b ο χρονοςειναι:%d και το σφαλμα:%d\n\n', n,m,tim2,f_2);
%
% 7.
% Για το ερωτημα 7 μετατρεπουμε με χρηση της sparse τα μητρωα σε αραια
% και ξανατρεχουμε τις μετρησεις
A=sparse(A);
B=sparse(B);
x1=newt(A,b);
x2=newt(B*W,W*b);
% Υπολογισμος χρονου επιλυσης και σχετικου σφαλματος
% για τις δυο νεες περιπτωσεις
t1=@() newt(A,b);
t2=@() newt(B*W,W*b);
tim=timeit(t1);
f_1=(norm(e-x1,inf))/norm(e,inf);
disp('Για τα νεα αραια μητρωα(ερωτημα 7):');
fprintf('\n-(n=%d,m=%d):\nΓια την επιλυση του Ax=b ο χρονος ειναι:%d και το σφαλμα:%d\n\n', n,m,tim,f_1);
tim2=timeit(t2);
f_2=(norm(e-x2,inf))/norm(e,inf);
fprintf('-(n=%d,m=%d):\nΓια την επιλυση του W*A*W_T*W*x=W*b ο χρονοςειναι:%d και το σφαλμα:%d\n\n', n,m,tim2,f_2);
end
end
%
%
%% ΜΕΡΟΣ Δ
%
%1.
%
i=1;
for n=[200:200:1400]
A=randn(n);
% Υπολογισμος χρονου εκτελεσης
X_t=@() qr(A);
t1(i)=timeit(X_t);
QR_t=@() qr(A);
t2(i)=timeit(QR_t,2);
n1(i)=n;
i=i+1;
end
p1=polyfit(n1,t1,3);
p2=polyfit(n1,t2,3);
% Μοντελοποιηση χρονου εκτελεσης
i=1;
for n=[200:200:1400]
T_X(i)=p1(1)*(n^3)+p1(2)*(n^2)+p1(3)*n+p1(4);
T_QR(i)=p2(1)*(n^3)+p2(2)*(n^2)+p2(3)*n+p2(4);
i=i+1;
end
%
% 2.
%
% Μοντελοποιηση χρονου εκτελεσης
i=1;
for n=[250:200:1750]
T_X_2(i)=p1(1)*(n^3)+p1(2)*(n^2)+p1(3)*n+p1(4);
T_QR_2(i)=p2(1)*(n^3)+p2(2)*(n^2)+p2(3)*n+p2(4);
i=i+1;
end
%
% 3.
i=1;
for n=[250:200:1750]
A=randn(n);
% Υπολογισμος χρονου εκτελεσης
X_t=@() qr(A);
t3(i)=timeit(X_t);
QR_t=@() qr(A);
t4(i)=timeit(QR_t,2);
n1(i)=n;
i=i+1;
end
%
%% 4.
%
i=1;
for n=[200:200:1400]
A=randn(n);
%  Υπολογισμος του χρονου εκτελεσης
X_t=@() qr(A);
t5(i)=timeit(X_t);
QR_t=@() qr(A);
t6(i)=timeit(QR_t,2);
n1(i)=n;
i=i+1;
end
p1=polyfit(n1,t5,3);
p2=polyfit(n1,t6,3);
p3=polyfit(n1,t5,2);
p4=polyfit(n1,t6,2);
p5=polyfit(n1,t5,4);
p6=polyfit(n1,t6,4);
% Μοντελοποιηση χρονου εκτελεσης
i=1;
for n=[200:200:1400]
T_X_1(i)=p1(1)*(n^3)+p1(2)*(n^2)+p1(3)*n+p1(4);
T_QR_1(i)=p2(1)*(n^3)+p2(2)*(n^2)+p2(3)*n+p2(4);
T_X_3(i)=p3(1)*(n^2)+p3(2)*n+p3(3);
T_X_4(i)=p5(1)*(n^4)+p5(2)*(n^3)+p5(3)*(n^2)+p5(4)*n+p5(5);
T_QR_3(i)=p4(1)*(n^2)+p4(2)*n+p4(3);
T_QR_4(i)=p6(1)*(n^4)+p6(2)*(n^3)+p6(3)*(n^2)+p6(4)*n+p6(5);
i=i+1;
end

