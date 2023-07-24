function L05E12_quadraticInterpolation

clc; clear all; clear hidden; close all

% General form of quadratic interpolating polynomials

% Experimental data
X = [3     4.5   7     9];
Y = [2.5   1     2.5   0.5];


% % Assume the 4 provided data points are going from left to right
% % Between every 2 data points, assume a general second order polynominal 
% % f(x) = a*x^2 + b*x + c is fitted
% % 
% % So between points 1 and 2 = Interval I:
% % f1(x) = a1*x^2 + b1*x + c1                                    -- Eq.(I)
% % 
% % ...and between points 2 and 3 = Interval II:
% % f2(x) = a2*x^2 + b2*x + c2                                   -- Eq.(II)
% % 
% % ...and between points 3 and 4 = Interval III:
% % f3(x) = a3*x^2 + b3*x + c3                                  -- Eq.(III)
% % 
% % 9 unknown variables = a1, b1, c1
% %                       a2, b2, c2
% %                       a3, b3, c3
% % So 9 equations are needed to solve for them.
% % 
% % ----------------
% % Point 1
% % ----------------
% % Point 1 conforms to Eq.(I)
% % f1(x) = a1*x^2  + b1*x + c1  
% % 2.5   = (3^2)a1 + 3b1  + c1
% % 2.5   =     9a1 + 3b1  + c1                                   -- Eq.(1)
% % 
% % We can also ASSUME that point 1 extends to the origin via a straight
% % line. In this case, the second derivative of the curve f1(x) at 
% % point 1 is zero.
% % f1(x)      = a1*x^2      + b1*x + c1
% % df1/dx     = 2*a1*x     + b1
% % d^2f1/dx^2 = 2*a1
% % 0          = 2*a1                                             -- Eq.(2)
% % 0          = a1                                                (SOLVED) 
% % 
% % ----------------
% % Point 2
% % ----------------
% % Point 2 conforms to both Eqs.(I) and (II)
% % f1(x) = a1*x^2    + b1*x  + c1  
% % 1     = (4.5^2)a1 + 4.5b1 + c1
% % 1     =   20.25a1 + 4.5b1 + c1                                -- Eq.(3)
% % 
% % and
% % 
% % f2(x) = a2*x^2    + b2*x  + c2
% % 1     = (4.5^2)a2 + 4.5b2 + c2
% % 1     =   20.25a2 + 4.5b2 + c2                                -- Eq.(4)
% % 
% % Since point 2 conforms to both Eqs.(I) and (II), the first  
% % derivatives of both equations at point 2 must also be equal.
% % f1(x) = a1*x^2      + b1*x + c1
% % df1/dx = 2*a1*x     + b1
% % df1/dx = 2(4.5)a1   + b1
% % df1/dx =      9a1   + b1
% % 
% % and
% % 
% % f2(x)  = a2*x^2     + b2*x + c2
% % df2/dx = 2*a2*x     + b2
% % df2/dx = 2(4.5)a2   + b2
% % df2/dx =      9a2   + b2
% % 
% % Given df1/dx   = df2/dx
% % 9a1 + b1 = 9a2 + b2
% % 0 = 9a1 + b1 - 9a2 - b2                                       -- Eq.(5)
% % 
% % ----------------
% % Point 3
% % ----------------
% % Point 3 conforms to both Eqs.(II) and (III)
% % f2(x) = a2*x^2  + b2*x + c2  
% % 2.5   = (7^2)a2 + 7b2  + c2
% % 2.5   =    49a2 + 7b2  + c2                                   -- Eq.(6)
% % 
% % and
% % 
% % f3(x) = a3*x^2  + b3*x + c3
% % 2.5   = (7^2)a3 + 7b3  + c3
% % 2.5   =  49a3   + 7b3  + c3                                   -- Eq.(7)
% %
% % 
% % Since point 3 conforms to both Eqs.(II) and (III), the first  
% % derivatives of both equations at point 3 must also be equal.
% % f2(x)  = a2*x^2     + b2*x + c2
% % df2/dx = 2*a2*x     + b2
% % df2/dx = 2(7)a2     + b2
% % df2/dx =   14a2     + b2
% % 
% % and
% % 
% % f3(x)  = a3*x^2      + b3*x + c3
% % df3/dx = 2*a3*x     + b3
% % df3/dx = 2(7)a3     + b3
% % df3/dx =   14a3     + b3
% % 
% % Given df2/dx = df3/dx
% % 14a2 + b2 = 14a3 + b3
% % 0 = 14a2 + b2 - 14a3 - b3                                     -- Eq.(8)
% % 
% % ----------------
% % Point 4
% % ----------------
% % Point 1 conforms to Eq.(III)
% % f3(x) = a3*x^2  + b3*x + c3  
% % 0.5   = (9^2)a3 + 9b3  + c3
% % 0.5   =    81a3 + 9b3  + c3                                   -- Eq.(9)



% ---
tic
disp('___________________________________________________________________')
disp('Using default MATLAB Gauss eliminaton functions')

% % Assembling the matrices from the equations

% % %    a1     b1      c1      a2      b2      c2      a3      b3      c3
% % A = [9      3       1       0       0       0       0       0       0;...
% %      0      0       0       0       0       0       0       0       0;...
% %      20.25  4.5     1       0       0       0       0       0       0;...
% %      0      0       0       20.25   4.5     1       0       0       0;...
% %      9      1       0      -9      -1       0       0       0       0;...
% %      0      0       0       49      7       1       0       0       0;...
% %      0      0       0       0       0       0       49      7       1;...
% %      0      0       0       14      1       0      -14     -1       0;...
% %      0      0       0       0       0       0       81      9       1];

% % B = [2.5;...
% %     0;...
% %     1;...
% %     1;...
% %     0;...
% %     2.5;...
% %     2.5;...
% %     0;...
% %     0.5];

% % Since the second row is all zeros in matrix A, and we know a1 = 0, 
% % we can remove the second row and the first column in A and,
% % the second row in B.
% % Here 

%    b1      c1      a2      b2      c2      a3      b3      c3
A = [3       1       0       0       0       0       0       0;...
     4.5     1       0       0       0       0       0       0;...
     0       0       20.25   4.5     1       0       0       0;...
     1       0      -9      -1       0       0       0       0;...
     0       0       49      7       1       0       0       0;...
     0       0       0       0       0       49      7       1;...
     0       0       14      1       0      -14     -1       0;...
     0       0       0       0       0       81      9       1];

B = [2.5;...
    1;...
    1;...
    0;...
    2.5;...
    2.5;...
    0;...
    0.5];


% Factorise the full or sparse matrix A into:
% L = a permuted lower triangular matrix, and
% U = an upper triangular matrix from Gaussian elimination with partial
%     pivoting
% such that A = L*U
[L, U] = lu(A);
% % If solving for the linear algebra problem A*C = B, then
C = U \ (L \ B); % where C = coefficients
% % which is equivalent to C = A\B or C = inv(A)*B
toc
C = [0; C]; % concatenate zero to the C array for a1
disp(' ')
disp('The equations of best-fit via quadratic interpolation are:')
disp(['f1(x) = ',num2str(C(1)),'.*(x.^2) + ', num2str(C(2)),'.*x  + ',num2str(C(3))]);
disp(['f2(x) = ',num2str(C(4)),'.*(x.^2) + ', num2str(C(5)),'.*x  + ',num2str(C(6))]);
disp(['f3(x) = ',num2str(C(7)),'.*(x.^2) + ', num2str(C(8)),'.*x  + ',num2str(C(9))]);
disp('___________________________________________________________________')


%%  Plot the figure 

% % For the interval between point 1 and point 2
x1 = X(1): 0.1: X(2);
y1 = C(1).*(x1.^2)    + C(2).*x1  + C(3);
% % For the interval between point 2 and point 3
x2 = X(2): 0.1: X(3);
y2 = C(4).*(x2.^2)    + C(5).*x2  + C(6);
% % For the interval between point 3 and point 4
x3 = X(3): 0.1: X(4);
y3 = C(7).*(x3.^2)    + C(8).*x3  + C(9);

plot(X, Y,'ok', x1, y1, 'r-', x2, y2, 'g-',x3, y3, 'b-', 'LineWidth', 2); 
xlabel('X');
ylabel('Y');

end