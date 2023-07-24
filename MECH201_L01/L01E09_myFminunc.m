function L1E9_myFminunc

clc; clear all; clear hidden; close all

tic
% Define an unconstrained multi-variable function
myfun = @(x) sin(x) + 3;

% Define a range of x to calculate f(x)
xTemp = 0:0.1:3*pi;
yTemp = myfun(xTemp);

% Plot the result
plot(xTemp, yTemp,'-b','LineWidth',2);
xlabel('x')
ylabel('myfun(x)')
hold all;

% % Find the local minimum of an unconstrained multi-variable function
% % by optimization
options = optimoptions(@fminunc,'Display','iter');
[xMin, fval_xMin] = fminunc(myfun,2)%,options)
toc

% Plot the local minima
plot(xMin, fval_xMin,'r*','LineWidth',2)
hold off;

end
