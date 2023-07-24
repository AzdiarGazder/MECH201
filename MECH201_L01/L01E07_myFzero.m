function L1E7_myFzero

clc; clear all; clear hidden; close all

tic
%% Find the roots of a non-linear function

% % The root of an equation is defined as the position where f(x) 
% % changes sign.

% Define a parameterized function
myfun = @(x,c)  x^10 + c;
% Define the parameter value(s)
c = -1;
% Define the function of x
fun = @(x) myfun(x,c);


% % If x0 is a scalar value
% % fzero begins at x0 and tries to locate a point x1 where fun(x1) has
% % the opposite sign of fun(x0).
% % Then fzero iteratively shrinks the interval where fun changes sign to
% % reach a solution.
x0 = 0;
options1 = optimset('Display','iter'); % show iterations
x1 = fzero(fun,0)%,options1)
disp('---')


% % If x0 is a 2-element vector:
% % In this case, fzero checks that fun(x0(1)) and fun(x0(2)) have
% % opposite signs, and errors if they do not.
% % It then iteratively shrinks the interval where fun changes sign to
% % reach a solution.
% % An interval x0 must be finite; it cannot contain ±Inf.
x0 = [0 2];
options2 = optimset('Display','iter'); % show iterations
x2 = fzero(fun,[0 2])%,options2)
%%
toc

end



