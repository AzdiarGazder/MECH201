function L05E04_leastSquaresRegression_saturationGrowthRateEquationFit
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%

% The saturation growth rate equation
%  y = alpha3 * (x / (beta3 + x))
% can be re-written as
% (1/y) = (1/alpha3) * (beta3 + x)/x
% (1/y) = (beta3/alpha3)/x + (1/alpha3)
% which is analogous to
% y = m*x  + c

%%
clc; clear all; clear hidden; close all

% Experimental data
xx = [20      40      60      80      100     120     140     160]
yy = [13.0072 22.3417 29.3667 34.8449 39.2365 42.8357 45.8391 48.3834] 

disp('------')

X = 1./xx
Y = 1./yy
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
    display(['equation: (1/y) = (', num2str(a1),' * (1/x)) + ',num2str(a0)]);
else
    display(['equation: (1/y) = (', num2str(a1),' * (1/x)) ',num2str(a0)]);
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
xlabel('X = 1/xx')
ylabel('Y = 1/yy')
legend({'Inverted experimental data', 'LSqR fit'},...
    'Location','southeast')
hold off;


alpha3 = 1/a0;
beta3 = a1 * alpha3;
disp('------')
display('Equation of best fit expressed as a saturation growth rate equation')
display(['alpha3 = ', num2str(alpha3)]);
display(['beta3  = ', num2str(beta3)]);
display(['equation: y = ', num2str(alpha3),' * (x / (',num2str(beta3),' + x))']);
disp('------')

% Substituting values into the best-fit equation
Ylsqr2 = alpha3 * (xx./(beta3 + xx));

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