function L05E02_powerEqnFit

clc; clear all; clear hidden; close all

%% Experimental data
xx = [1 2 3 4 5];
yy = [0.5 1.7 3.4 5.7 8.4];

X = log10(xx);
Y = log10(yy);

%% Linear regression
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
display('Least Squares Regression equation')
display(['a1 = ', num2str(a1)]);
display(['a0 = ', num2str(a0)]);
display(['equation: y = (', num2str(a1),' * x) ',num2str(a0)]);


% The linear regression equation
% a0 = y - a1*x
% can be re-written as
% y = a1*x + a0
% which is analogous to
% y = m*x  + c
Yreg = a1*X + a0;


% Correlation coefficient / (coefficient of determination):
Sr = sum((Y - a0 -a1*X).^2);
Sl = sum((Y - YAvg).^2);
Syx = sqrt(Sr/(n-2));
r = sqrt((Sl-Sr)/Sl);
r2 = r.^2;

disp('------')
display('Correlation coefficients')
display(['Sr = ', num2str(Sr)]);
display(['Sl = ', num2str(Sl)]);
display(['Syx = ', num2str(Syx)]);
display(['r = ', num2str(r)]);
display(['r^2 = ', num2str(r2)]);
disp('------')


figure
plot(X,Y,'o-r','linewidth',2)
hold all;
plot(X,Yreg,'*-b','linewidth',2)
xlabel('X = log10(xx)')
ylabel('Y = log10(yy)')
legend({'Log10 experimental data', 'LSQR data'},...
    'Location','southeast')
hold off;


beta = a1;
alpha = 10^a0;
disp('------')
display('Expressed as a power law')
display(['beta = ', num2str(beta)]);
display(['alpha = ', num2str(alpha)]);
display(['equation: y = ', num2str(alpha),' * (x ^ ',num2str(beta),')']);

% Substituting values into the best-fit equation
Yreg = alpha * (xx.^beta);

figure
plot(xx,yy,'o-r','linewidth',2)
hold all;
plot(xx,Yreg,'*-b','linewidth',2)
xlabel('xx')
ylabel('yy')
legend({'Experimental data', 'LSQR data'},...
    'Location','southeast')
hold off;

end