function rnk=SMW(A,n,t)
%
A_1=A^-1; % αντιστροφος του Α
W = randn(n,t);
H = randn(n,t);
H_T= reshape(H,n,[])'; % ο αναστροφος του Η
rnk=rank(((A+W*H_T)^-1)-A_1); % σχεση [1]
end