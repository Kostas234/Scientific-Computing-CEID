% Matlab Benchmark (2 April 2001)
% Author : Philippe Grosjean
% eMail  : phgrosjean@sciviews.org
% Web    : http://www.sciviews.org
% License: GPL 2 or above at your convenience (see: http://www.gnu.org)
%
% Several tests are adapted from:
%***************************************************************************
%* Matlab Benchmark program version 2.0                                    *
%* Author : Stefan Steinhaus                                               *
%* EMAIL  : stst@informatik.uni-frankfurt.de                               * 
%* This program is public domain. Feel free to copy it freely.             *
%***************************************************************************
% Escoufier's equivalents vectors (III.5) is adapted from Planque & Fromentin, 1996 
% Ref: Escoufier Y., 1970. Echantillonnage dans une population de variables
% aleatoires réelles. Publ. Inst. Statis. Univ. Paris 19 Fasc 4, 1-47.
%
% Type "cd('c:/<dir>')" and then "matlab" to start the test

clc

runs = 15;			% Number of times the tests are executed
times = zeros(5, 3);

disp('   Matlab Benchmark')
disp('   ================')
disp(['Number of times each test is run__________________________: ' num2str(runs)])
disp(' ')


disp('   I. Matrix calculation')
disp('   ---------------------')


% (1)
cumulate = 0; a = 0; b = 0;
for i = 1:runs
  tic;
    a = abs(randn(1200, 1200)/10);
    b = a';
    a = reshape(b, 600, 2400);
    b = a';
  timing = toc;
  cumulate = cumulate + timing;
end;
timing = cumulate/runs;
times(1, 1) = timing;
disp(['Creation, transp., deformation of a 1200x1200 matrix (sec): ' num2str(timing)])
clear a; clear b;

% (2)
cumulate = 0; b = 0;
for i = 1:runs
  a = abs(randn(1250, 1250)/2);
  tic; 
    b = a.^1000; 
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(2, 1) = timing;
disp(['1250x1250 normal distributed random matrix ^1000____ (sec): ' num2str(timing)])
clear a; clear b;

% (3)
cumulate = 0; b = 0;
for i = 1:runs
  a = randn(1100000, 1);
  tic;
    b = sort(a);
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(3, 1) = timing;
disp(['Sorting of 1,100,000 random values__________________ (sec): ' num2str(timing)])
clear a; clear b; 

% (4)
cumulate = 0; b = 0;
for i = 1:runs
  a = randn(550, 550);
  tic;
    b = a'*a;
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(4, 1) = timing;
disp(['550x550 cross-product matrix (b = a'' * a)___________ (sec): ' num2str(timing)])
clear a; clear b;

% (5)
cumulate = 0; c = 0;
for i = 1:runs
  a = randn(700, 700);
  b = 1:700;
  tic;
    c = a\b';
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(5, 1) = timing;
disp(['Linear regression over a 700x700 matrix (c = a \ b'') (sec): ' num2str(timing)])
clear a; clear b; clear c;

times = sort(times);
disp('                      --------------------------------------------')
disp(['                      Trimmed mean (2 extremes eliminated): ' num2str(mean(times(2:4,1)))])
disp(' ')

disp('   II. Matrix functions')
disp('   --------------------')


% (1)
cumulate = 0; b = 0;
for i = 1:runs
  a = randn(900000, 1);
  tic;
    b = fft(a);
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(1, 2) = timing;
disp(['FFT over 900,000 random values______________________ (sec): ' num2str(timing)])
clear a; clear b;

% (2)
cumulate = 0; b = 0;
for i = 1:runs
  a = randn(220, 220);
  tic;
    b = eig(a);
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(2, 2) = timing;
disp(['Eigenvalues of a 220x220 random matrix______________ (sec): ' num2str(timing)])
clear a; clear b;

% (3)
cumulate = 0; b = 0;
for i = 1:runs
  a = randn(750, 750);
  tic;
    b = det(a);
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(3, 2) = timing;
disp(['Determinant of a 750x750 random matrix______________ (sec): ' num2str(timing)])
clear a; clear b;

% (4)
cumulate = 0; b = 0;
for i = 1:runs
  a = randn(1000, 1000);
  a = a'*a;
  tic;
    b = chol(a);
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(4, 2) = timing;
disp(['Cholesky decomposition of a 1000x1000 matrix________ (sec): ' num2str(timing)])
clear a; clear b;

% (5)
cumulate = 0; b = 0;
for i = 1:runs
  a = randn(500, 500);
  tic;
    b = inv(a);
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(5, 2) = timing;
disp(['Inverse of a 500x500 random matrix__________________ (sec): ' num2str(timing)])
clear a; clear b;

times = sort(times);
disp('                      --------------------------------------------')
disp(['                      Trimmed mean (2 extremes eliminated): ' num2str(mean(times(2:4,2)))])
disp(' ')

disp('   III. Programmation')
disp('   ------------------')

% (1)
cumulate = 0; a = 0; b = 0; phi = 1.6180339887498949;
for i = 1:runs
  a = floor(1000 * rand(225000, 1));
  tic;	  
    b = (phi.^a - (-phi).^(-a)) / sqrt(5);
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(1, 3) = timing;
disp(['225,000 Fibonacci numbers calculation (vector calc)_ (sec): ' num2str(timing)])
clear a; clear b; clear phi;

% (2)
cumulate = 0; a = 1500; b = 0;
for i = 1:runs
  tic;
    b = ones(a, a)./((1:a)' * ones(1, a) + ones(a, 1) * (0:(a-1)));    
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(2, 3) = timing;
disp(['Creation of a 1500x1500 Hilbert matrix (matrix calc) (sec): ' num2str(timing)])
clear a; clear b;

% (3)
cumulate = 0; c = 0;
for i = 1:runs
  a = ceil(1000 * rand(35000, 1));
  b = ceil(1000 * rand(35000, 1));
  tic;	  
    c = gcd2(a, b);                            % gcd2 is a recursive function
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(3, 3) = timing;
disp(['Grand common divisors of 35,000 pairs (recursion)___ (sec): ' num2str(timing)])
clear a; clear b; clear c;

% (4)
cumulate = 0; b = 0;
for i = 1:runs
  b = zeros(220, 220);
  tic;
    for j = 1:220
      for k = 1:220
        b(k,j) = abs(j - k) + 1;
      end
    end
  timing = toc;
  cumulate = cumulate + timing;
end
timing = cumulate/runs;
times(4, 3) = timing;
disp(['Creation of a 220x220 Toeplitz matrix (loops)_______ (sec): ' num2str(timing)])
clear b; clear j; clear k;

% (5)
cumulate = 0; p = 0; vt = 0; vr = 0; vrt = 0; rvt = 0; RV = 0; j = 0; k = 0;
x2 = 0; R = 0; Rxx = 0; Ryy = 0; Rxy = 0; Ryx = 0; Rvmax = 0; f = 0;
for i = 1:runs
  x = abs(randn(22, 22));
  tic;
    % Calculation of Escoufier's equivalent vectors
    p = size(x, 2);
    vt = [1:p];                                % Variables to test
    vr = [];                                   % Result: ordered variables
    RV = [1:p];                                % Result: correlations
    for j = 1:p                                % loop on the variable number
      Rvmax = 0;
      for k = 1:(p-j+1)                        % loop on the variables
        x2 = [x, x(:, vr), x(:, vt(k))];       % New table to test
        R = corrcoef(x2);                      % Correlations table
        Ryy = R(1:p, 1:p);
        Rxx = R(p+1:p+j, p+1:p+j);
        Rxy = R(p+1:p+j, 1:p);
        Ryx = Rxy';
        rvt = trace(Ryx*Rxy)/((trace(Ryy^2)*trace(Rxx^2))^0.5); % RV calculation
        if rvt > Rvmax
          Rvmax = rvt;                         % test of RV
          vrt(j) = vt(k);                      % temporary held variable
        end
      end
      vr(j) = vrt(j);                          % Result: variable
      RV(j) = Rvmax;                           % Result: correlation
      f = find(vt~=vr(j));                     % identify the held variable
      vt = vt(f);                              % reidentify variables to test
    end
  timing = toc;
  cumulate = cumulate + timing;
end
times(5, 3) = timing;
disp(['Escoufier''s method on a 22x22 matrix (mixed)________ (sec): ' num2str(timing)])
clear x; clear p; clear vt; clear vr; clear vrt; clear rvt; clear RV; clear j; clear k;
clear x2; clear R; clear Rxx; clear Ryy; clear Rxy; clear Ryx; clear Rvmax; clear f; 

times = sort(times);
disp('                      --------------------------------------------')
disp(['                      Trimmed mean (2 extremes eliminated): ' num2str(mean(times(2:4,3)))])
disp(' ')

disp(' ')
disp(['Total time for all 15 tests_________________________ (sec): ' num2str(sum(sum(times)))])
disp(['Overall mean (sum of I, II and III trimmed means/3)_ (sec): ' num2str(mean(mean(times(2:4,:))))])
clear cumulate; clear timing; clear times; clear runs; clear i;
disp('                      --- End of test ---')     