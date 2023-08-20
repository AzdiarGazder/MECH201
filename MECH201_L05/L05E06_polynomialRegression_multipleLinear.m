function L05E06_polynomialRegression_multipleLinear
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Example data from:
% https://au.mathworks.com/help/stats/regress.html
%
%%


%%
clc; clear all; clear hidden; close all

% Experimental data
load carsmall
X1 = Weight;
X2 = Horsepower; 
Y = MPG;
idx = ~(isnan(X1) | isnan(X2) | isnan(Y)); % since MATLAB's default experimental data contains NaN data
X1 = X1(idx);
X2 = X2(idx);
Y = Y(idx);

% X1 = [0 2  2.5 1 4 7]
% X2 = [0 1  2   3 6 2]
% Y =  [5 10 9   0 3 27]

disp('___________________________________________________________________')


% Multiple linear regression
n = length(Y);
Sx1 = sum(X1);
Sx2 = sum(X2);
Sx1sq = sum(X1.^2);
Sx1x2 = sum(X1.*X2);
Sx2sq = sum(X2.^2);

Sy = sum(Y);
Sx1y = sum(X1.*Y);
Sx2y = sum(X2.*Y);

X1Avg = mean(X1);
X2Avg = mean(X2);
YAvg = mean(Y);

%% ---
tic
disp('------')
disp('Using default MATLAB Gauss eliminaton functions')
A = [n  Sx1   Sx2;...
    Sx1 Sx1sq Sx1x2;...
    Sx2 Sx1x2 Sx2sq]

B = [Sy;...
    Sx1y;...
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
Yreg = a0 + a1.*X1 + a2.*X2;


% Correlation coefficient / (coefficient of determination):
Sr = sum((Y -a0 -(a1.*X1) -(a2.*X2)).^2);
Sl = sum((Y - YAvg).^2);
m = 2; % polynominal order
Syx = sqrt(Sr/(n- (m + 1)));
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
scatter3(X1,X2,Y,'r','filled'); % plot the X1, X2 & Y experimental data
hold all
scatter3(X1,X2,Yreg,'b','filled'); % plot the X1, X2 experimental data & Y data from regression

% make vectors for plotting the plane of best-fit
[X1fit,X2fit] = meshgrid(min(X1):max(X1),min(X2):max(X2));
Yfit = a0 + a1.*X1fit + a2.*X2fit;
mesh(X1fit,X2fit,Yfit)

xlabel('Weight');
ylabel('Horsepower');
zlabel('MPG');
view(45,45);
hold off

end