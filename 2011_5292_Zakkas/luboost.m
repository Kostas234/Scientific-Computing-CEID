function [L, U, T]=luboost(A)
%
[m, n] = size(A);
if m < n, error('Matrix must be m-by-n with m >= n.'), end
if nargin < 2, piv = ''; end
pp = 1:m; qq = 1:n;
ncomp = 0;

for k = 1:min(m-1,n)

if A(k,k) == 0
      if strcmp(piv, '') % Zero pivot is problem only for no pivoting.
         error('Elimination breaks down with zero pivot.  Quitting...')
      end
end

    i = k+1:m;
    if A(k,k) ~= 0  % Simplest way to handle zero pivot for partial and rook.
       A(i,k) = A(i,k)/A(k,k);          % Multipliers.
    end

    if k+1 <= n
       % Elimination
       j = k+1:n;
       A(i,j) = A(i,j) - A(i,k) * A(k,j);
    end

end

if nargout <= 1
   L = A;
   return
end

L = tril(A,-1) + eye(m,n);
U = triu(A);
U = U(1:n,:);

if nargout >= 3, P = eye(m); P = P(pp,:); end
if nargout >= 4, Q = eye(n); Q = Q(:,qq); end

end % ths function
