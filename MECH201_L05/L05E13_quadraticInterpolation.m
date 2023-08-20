function L05E13_quadraticInterpolation
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% % If three points (x0, f(x0)), (x1, f(x1)) and (x2, f(x2)) are known, 
% % then f(x) at a point x, if located between x0 and x2, can be estimated 
% % by quadratic interpolation. 
% %
% % The quadratic formula can be expressed as:
% % f(x) = b0 + b1*(x - x0) + b2*(x - x0)*(x - x1)....

x0 = 1; fx0 = log(x0); % known point 1
x1 = 4; fx1 = log(x1); % known point 2
x2 = 6; fx2 = log(x2); % known point 3

disp('___________________________________________________________________')
disp(['x0 = ', num2str(x0), '; f(x0) = ',num2str(fx0)])
disp(['x1 = ', num2str(x1), '; f(x1) = ',num2str(fx1)])
disp(['x2 = ', num2str(x2), '; f(x2) = ',num2str(fx2)])
disp('___________________________________________________________________')

disp('----')

x = 2; % unknown point

b0 = fx0;
b1 = (fx1 - fx0) / (x1 - x0);
% b2 = (((fx2 - fx1) / (x2 - x1)) - ((fx1 - fx0) / (x1 - x0))) / (x2 - x0);
% Which can also be re-written as:
b2 =  (((fx2 - fx1) / (x2 - x1)) - b1) / (x2 - x0);
fx = b0 + b1*(x - x0) + b2*(x - x0)*(x - x1);

disp('___________________________________________________________________')
disp(['b0 = ', num2str(b0)]);
disp(['b1 = ', num2str(b1)]);
disp(['b2 = ', num2str(b2)]);
disp(['x  = ', num2str(x), ' ; f(x)  = ',num2str(fx)])
disp('___________________________________________________________________')


end
