function L05E02_leastSquaresRegression_powerEquationFit
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%

% The power equation
% y = alpha2 * x ^ beta2
% log10(y) = log10(alpha2) + (beta2 * log10(x))
% can be re-written as
% log10(y) = (beta2 * log10(x)) + log10(alpha2) 
% which is analogous to
% y = m*x  + c

%%
clc; clear all; clear hidden; close all

% Experimental data
xx = [1   2   3   4   5]
yy = [0.5 1.7 3.4 5.7 8.4]

disp('------')

X = log10(xx)
Y = log10(yy)
disp('___________________________________________________________________')


% Linear regression
n = length(Y);
Sx = sum(X);
Sy = sum(Y);
Sxy = sum(X.*Y);

Sxx = sum(X.^2);
Sx2 = (sum(X))^2;

XAvg = sum(X) / n;
YAvg = sum(Y) / n;

a1 = (n*Sxy - Sx*Sy) / (n*Sxx - Sx2);
a0 = YAvg - a1*XAvg;

disp('------')
display('Equation of best fit by Least Squares Regression linearisation')
display(['a1 = ', num2str(a1)]);
display(['a0 = ', num2str(a0)]);
if sign(a0) == 1
    display(['equation: log10(y) = (', num2str(a1),' * log10(x)) + ',num2str(a0)]);
else
    display(['equation: log10(y) = (', num2str(a1),' * log10(x)) ',num2str(a0)]);
end


% Substituting values into the best-fit equation
Ylsqr1 = a1*X + a0;


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


figure
plot(X,Y,'o-r','linewidth',2)
hold all;
plot(X,Ylsqr1,'*-b','linewidth',2)
xlabel('X = log10(xx)')
ylabel('Y = log10(yy)')
legend({'Log10 experimental data', 'LSqR fit'},...
    'Location','southeast')
hold off;


beta2 = a1;
alpha2 = 10^a0;
disp('------')
display('Equation of best fit expressed as a power law')
display(['alpha2 = ', num2str(alpha2)]);
display(['beta2  = ', num2str(beta2)]);
display(['equation: y = ', num2str(alpha2),' * (x ^ ',num2str(beta2),')']);
disp('------')

% Substituting values into the best-fit equation
Ylsqr2 = alpha2 * (xx.^beta2);

figure
plot(xx,yy,'o-r','linewidth',2)
hold all;
plot(xx,Ylsqr2,'*-b','linewidth',2)
xlabel('xx')
ylabel('yy')
legend({'Experimental data', 'LSqR fit'},...
    'Location','southeast')
hold off;

end