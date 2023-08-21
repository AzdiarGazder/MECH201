function L05E16_lagrangeInterpolation_example2
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% General form of Lagrange's linear interpolating polynomials

X = [0, 1, 2, 3]  % data points
Y = [2, 1, 0,-1]  % y = f(X)
disp('___________________________________________________________________')


syms x
sumEq = 0;                % define a zero sum equation

for ii = 1:length(X)

    disp('----')
    nums4Product = X;
    num2Subtract = nums4Product(ii) % the number to subtract in the current loop
    nums4Product(ii) = [] % the remaining numbers in the array making up the product
    
    L = prod((x - nums4Product)./(num2Subtract - nums4Product),'all'); % find the product
    disp(['Lagrangrian product in loop ',num2str(ii),' = ']);
    pretty(L)
    
    sumEq = sumEq + (L * Y(ii)); % add the current product to the equation sum
    L = [];
end
disp('___________________________________________________________________')

disp('The Lagrangian equation of best-fit:')
disp(vpa(simplify(sumEq)))
disp('___________________________________________________________________')


figure
plot(X,Y,'o-r','lineWidth',2); % data points
hold all;
fplot(sumEq,[min(X) max(X)],'-k','lineWidth',2);
legend('f(x)','Lagrangian interpolation','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');


end
