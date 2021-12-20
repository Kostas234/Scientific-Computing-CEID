function [k,err]= itref_double(A,W,H,b)
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
end