function L05E01_leastSquaresRegression_linearFit
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%

% The linear equation
% a0 = y - a1*x
% can be re-written as
% y = a1*x + a0
% which is analogous to
% y = m*x  + c

%%
clc; clear all; clear hidden; close all

% Experimental data
X = [1   2   3   4   5   6   7]
Y = [0.5 2.5 2.0 4.0 3.5 6.0 5.5]
disp('___________________________________________________________________')


% Linear regression
n = length(Y);
Sx = sum(X);
Sy = sum(Y);
Sxy = sum(X.*Y);

Sxx = sum(X.^2);
Sx2 = (sum(X))^2;

YAvg = mean(Y); % sum(Y) / n;
XAvg = mean(X); % sum(X) / n;

a1 = (n*Sxy - Sx*Sy) / (n*Sxx - Sx2);
a0 = YAvg - a1*XAvg;

disp('------')
display('Equation of best fit by Least Squares Regression')
display(['a1 = ', num2str(a1)]);
display(['a0 = ', num2str(a0)]);
if sign(a0) == 1
    display(['equation: y = (', num2str(a1),' * x) + ',num2str(a0)]);
else
    display(['equation: y = (', num2str(a1),' * x) ',num2str(a0)]);
end


% Substituting values into the best-fit equation
Ylsqr = a1*X + a0;


% Correlation coefficient / (coefficient of determination):
Sr = sum((Y - a0 -a1*X).^2);
Sl = sum((Y - YAvg).^2);
Syx = sqrt(Sr/(n-2));
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
plot(X,Ylsqr,'*-b','linewidth',2)
xlabel('X')
ylabel('Y')
legend({'Experimental data', 'LSqR fit'},...
    'Location','southeast')
hold off;

end