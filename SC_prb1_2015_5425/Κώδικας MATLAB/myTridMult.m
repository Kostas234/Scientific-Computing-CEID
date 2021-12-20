function [G]= myTridMult(matrix1,matrix2)

    n= length(matrix1);
    A= matrix1;
    B= matrix2;
    G= zeros(n,n); %neo mhtrwo me to ginomeno twn A,B
    
    G(1,1)=A(1,1)*B(1,1)+A(1,2)*B(2,1); % arxiko kai teliko stoixeio ths kurias diagwniou
    G(n,n)=A(n,n-1)*B(n-1,n)+A(n,n)*B(n,n);
        
    for i=1:n-1
               
        G(i,i+1)=A(i,i)*B(i,i+1)+A(i,i+1)*B(i+1,i+1); %stoixeia stin uper-diagwnio
        G(i+1,i)=A(i+1,i)*B(i,i)+A(i+1,i+1)*B(i+1,i); %stoixeia stin upo-diagwnio
        
        if i <= n-2 % stoixeia ektos 3 diagwniwn
        G(i,i+2)=A(i,i+1)*B(i+1,i+2);
        G(i+2,i)=A(i+2,i+1)*B(i+1,i);
        end
        
        if i>1 %stoixeia kurias diagwniou ektws (1,1) kai (n,n)
        G(i,i)=A(i,i-1)*B(i-1,i)+A(i,i)*B(i,i)+A(i,i+1)*B(i+1,i);
        end
     end
end