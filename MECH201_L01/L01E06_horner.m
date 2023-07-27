function L01E06_horner
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% From https://au.mathworks.com/matlabcentral/answers/562466-plotting-a-function-horner-schema
% 
%%


%%
clc; clear all; clear hidden; close all

% Define a quartic (4th degree) polynomial equation
syms x;
P = 2*x^4 + 3*x^3 - 3*x^2 + 5*x - 1;
disp('Define a quartic (4th degree) polynomial equation:')
disp(P)
% Use MATLAB's in-built Horner method
disp('Using MATLAB''s in-built Horner method:')
disp(horner(P,x))
% Evaluate the polynomial at x = 0.5
disp(['At x = 0.5, P = ',num2str(eval(subs(P,x,0.5)))])
disp(' ')
disp('------')

tic
%% Using a custom Horner script
% %
% % General Horner representation:
% % If a polynomial is represented by coefficients "a" such that
% % a(n+1)*x^n + a(n)*x^n-1 + a(n-1)*x^n-2 + ... + a(1)
% % then the polynomial can be rewritten as
% % a1 + x*(a2 + x*(a3 + x*(a4 + x*(..... ))))))
% %
% % In the case of the quartic (4th degree) polynomial equation:
% % a5*x^4 + a4*x^3 + a3*x^2 + a2*x + a1
% % the Horner representation is
% % a1 + x*(a2 + x*(a3 + x*(a4 + a5*x)))

% % Horner's method of calculation:
% % Hint - In the expression, begin within the deepest parenthesis and work 
% % outwards. 
% % In the present case, the coefficient a5 is first multiplied by x.
% % Then the product is added of the preceding coefficient a4.
% % This loop is repeated until the end of the equation.

% Define symbolic coefficients (including the constant) a1 to a5
a = sym('a',[1,5]); 
syms x;
PP = myHorner(a,x);
disp('Using myHorner method:')
disp(PP)

% Define an array of coefficients of the polynomial (including the 
% constant) in the order of increasing powers of x
aa = fliplr([2 3 -3 5 -1]); 
% Substitute the coefficients array into myHorner
PP = myHorner(aa,x);
disp('Substitute the coefficients into myHorner:')
disp(PP)

% Return the original equation P
disp('Expand the output from myHorner back to the original polynomial equation:')
disp(expand(PP))

% Re-evaluate the polynomial at x = 0.5
disp(['At x = 0.5, P = ',num2str(myHorner(aa,0.5))])
disp(' ')
disp('---')
%%
toc

% Plot the polynomial equation between x limits of [-5 5]
fplot(@(x) myHorner(aa,x),[-5,5],'-b','LineWidth',2)
xlabel('x')
ylabel('P(x)')
end






function p = myHorner(aa,xx)
% Horner's method to evaluate a polynomial
% aa = coefficients of the polynomial (including the constant) stored in 
%      the order of increasing powers of x.
% xx = a scalar, vector, or an array of any size or shape.

% calulate the degree of the polynomial
n = length(aa)-1;

% pre-allocate p to be the same shape and size as x but initialised to
% contain copies of a(n+1).
p = repmat(aa(n+1),size(xx));

for ii = n:-1:1
    % Note the use of .* to multiply by x.
    % Since p may potentially be a vector or array of the same shape
    % and size as x, multiply every element of p by the corresponding
    % element of x.
    p = p.*xx + aa(ii);
end
end