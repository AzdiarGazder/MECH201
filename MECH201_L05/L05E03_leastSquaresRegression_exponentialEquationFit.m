function L05E03_leastSquaresRegression_exponentialEquationFit
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%

% The exponential equation
% y = alpha1 * exp(beta1 * x)
% ln(y) = ln(alpha1) + (beta1 * x)
% can be re-written as
% ln(y) = (beta1 * x) + ln(alpha1)
% which is analogous to
% y = m*x  + c

%%
clc; clear all; clear hidden; close all

% Experimental data
xx = [1.0000    1.0056    1.0112    1.0168    1.0223    1.0279    1.0335...
      1.0391    1.0447    1.0503    1.0559    1.0615    1.0670    1.0726...
      1.0782    1.0838    1.0894    1.0950    1.1006    1.1061    1.1117]

yy = [5.7874    7.1317    8.7883   10.8297   13.2957   16.3840   20.1898...
     24.8796   30.6588   37.7804   46.5562   57.3705   70.4336   86.7944...
    106.9554  131.7996  162.4147  200.1413  246.6312  302.7885  373.1219]

disp('------')

X = xx
Y = log(yy)
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
    display(['equation: ln(y) = (', num2str(a1),' * x) + ',num2str(a0)]);
else
    display(['equation: ln(y) = (', num2str(a1),' * x) ',num2str(a0)]);
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
xlabel('X = xx')
ylabel('Y = log(yy)')
legend({'log_N experimental data', 'LSqR fit'},...
    'Location','southeast')
hold off;



alpha1 = exp(a0);
beta1 = a1;
disp('------')
display('Equation of best fit expressed as an exponential function')
display(['alpha1 = ', num2str(alpha1)]);
display(['beta1  = ', num2str(beta1)]);
display(['equation: y = ', num2str(alpha1),' * exp(',num2str(beta1),' * x)']);
disp('------')

% Substituting values into the best-fit equation
Ylsqr2 = alpha1 .* exp(beta1 .* xx);

figure
plot(xx,yy,'o-r','linewidth',2)
hold all;
plot(xx,Ylsqr2,'*-b','linewidth',2)
xlabel('xx')
ylabel('yy')
legend({'Experimental data', 'LSqR fit'},...
    'Location','northwest')
hold off;

end