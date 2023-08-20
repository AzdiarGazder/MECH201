function L05E05_polynomialRegression
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% Experimental data
X = [0   1    2    3    4    5]
Y = [2.1 7.7 13.6 27.2 40.9 61.1]
disp('___________________________________________________________________')


% Linear regression
n = length(Y);
Sx = sum(X);
Sy = sum(Y);

Sxy = sum(X.*Y);
Sx2y = sum((X.^2).*Y);

Sx2 = sum(X.^2);
Sx3 = sum(X.^3);
Sx4 = sum(X.^4);

YAvg = mean(Y);
XAvg = mean(X);


%% ---
tic
disp('------')
disp('Using default MATLAB Gauss eliminaton functions')
A = [n  Sx  Sx2;...
    Sx  Sx2 Sx3;...
    Sx2 Sx3 Sx4]

B = [Sy;...
    Sxy;...
    Sx2y]

% Factorise the full or sparse matrix A into:
% L = a permuted lower triangular matrix, and
% U = an upper triangular matrix from Gaussian elimination with partial
%     pivoting
% such that A = L*U
[L, U] = lu(A);
% % If solving for the linear algebra problem A*XX = B, then
XX = U \ (L \ B);
% % which is equivalent to XX = A\B or XX = inv(A)*B
a0 = XX(1); a1 = XX(2); a2 = XX(3);
toc
disp('___________________________________________________________________')


disp('------')
display('Least Squares Regression equation')
display(['a2 = ', num2str(a2)]);
display(['a1 = ', num2str(a1)]);
display(['a0 = ', num2str(a0)]);
display(['equation: y = ', num2str(a0),' + (', num2str(a1),' * x) + (', num2str(a2),' * x^2) ']);

% Substituting values into the best-fit equation
Yreg = a0 + a1.*X + a2.*(X.^2);


% Correlation coefficient / (coefficient of determination):
Sr = sum((Y -a0 -(a1.*X) -(a2.*X.^2)).^2);
Sl = sum((Y - YAvg).^2);
m = 2; % polynominal order
Syx = sqrt(Sr/(n-(m+1)));
r = sqrt((Sl-Sr)/Sl);
r2 = r.^2;

disp('------')
display('Correlation coefficients')
display(['Sr  = ', num2str(Sr)]);
display(['Sl  = ', num2str(Sl)]);
display(['Syx = ', num2str(Syx)]);
display(['r   = ', num2str(r)]);
display(['r^2 = ', num2str(r2)]);
disp('------')


figure
plot(X,Y,'o-r','linewidth',2)
hold all;
plot(X,Yreg,'*-b','linewidth',2)
xlabel('X')
ylabel('Y')
legend({'Experimental data', 'LSqR fit'},...
    'Location','southeast')
hold off;

end