function L05E12_linearInterpolation
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% % Linear interpolation using similar triangles
% %
% % If two points (x0, f(x0)) and (x1, f(x1)) are known, then f(x) at a
% % point x, if located between x0 and x1, can be estimated by linear
% % interpolation.
% %
% % (f(x) - f(x0)) / (x - x0) = (f(x1) - f(x0)) / (x1 - x0)
% % Rearranging the equation for f(x)
% %
% % f(x) = f(x0) + (((f(x1) - f(x0)) / (x1 - x0)) * (x - x0))

x0 = 1; fx0 = log(x0); % known point 1
x1 = 6; fx1 = log(x1); % known point 2

x = 2; % unknown point
fx = fx0 + (((fx1 - fx0) / (x1 - x0)) * (x - x0));

disp('___________________________________________________________________')
disp(['x0 = ', num2str(x0), '; f(x0) = ',num2str(fx0)])
disp(['x1 = ', num2str(x1), '; f(x1) = ',num2str(fx1)])
disp(['x  = ', num2str(x), '; f(x)  = ',num2str(fx)])
disp('___________________________________________________________________')

disp('----')

x1 = 4; fx1 = log(x1); % known point 2

x = 2; % unknown point (shorter interval)
fx = fx0 + (((fx1 - fx0) / (x1 - x0)) * (x - x0));

disp('___________________________________________________________________')
disp(['x0 = ', num2str(x0), '; f(x0) = ',num2str(fx0)])
disp(['x1 = ', num2str(x1), '; f(x1) = ',num2str(fx1)])
disp(['x  = ', num2str(x), '; f(x)  = ',num2str(fx)])
disp('___________________________________________________________________')

end
