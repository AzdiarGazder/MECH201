function L05E11_lagrangeInterpolation

clc; clear all; clear hidden; close all

% General form of Lagrange's linear interpolating polynomials

X = [1, 4, 6] % data points
Y = log(X)    % y = f(X)
disp('___________________________________________________________________')


xLagrange = min(X): 0.1: max(X); % defines finer steps between points
% for the equation of best-fit
yLagrange = log(xLagrange);

syms x
sumEq = 0;                % define a zero sum equation

for ii = 1:length(X)

    disp('----')
    nums4Prod = X;
    num2Subtract = nums4Prod(ii) % the number to subtract in the current loop
    nums4Prod(ii) = [] % the remaining numbers in the array making up the product
    
    L = prod((x - nums4Prod)./(num2Subtract - nums4Prod),'all'); % find the product
    disp(['Lagrangrian product in loop ',num2str(ii),' = ']);
    pretty(L)
    
    sumEq = sumEq + (L * Y(ii)); % add the current product to the equation sum
    L = [];
end
disp('___________________________________________________________________')


figure
plot(X,Y,'o-r','lineWidth',2); % data points
hold all;
fplot(sumEq,[min(X) max(X)],'-k','lineWidth',2); % keep
legend('f(x)','Lagrangian interpolation','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');


end
