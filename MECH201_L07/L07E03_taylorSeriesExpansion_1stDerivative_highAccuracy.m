function L07E03_taylorSeriesExpansion_1stDerivative_highAccuracy
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/213823-forward-backward-and-central-differences
%
%%


%% 
clc; clear all; clear hidden; close all

disp('___________________________________________________________________')
syms x f
f(x) = -0.1.*x.^4 -0.15.*x.^3 -0.5.*x.^2 -0.25.*x +1.2 % define a function

% step sizes
stepSize = 0.05; 

% x-values for which derivatives require calculation
x = linspace(0,1,(1/stepSize)+1);

% Analytical solution
df_dx = diff(f,1)
Df = double(df_dx(x));
disp('___________________________________________________________________')


%% Taylor series expansion (1st order approximation)
F = f(x); % to enable the replacing of different x values into the equation 
% % Forward divided difference
x_forward = x(1:end-2);
dF_forward = double((-F(3:end) + 4.*F(2:end-1) - 3.*F(1:end-2)) ./ (2*stepSize));
err_forward = 100.*abs((Df(1:end-2) - dF_forward) ./ Df(1:end-2));

% % Backward divided difference
x_backward = x(3:end);
dF_backward = double((3.*F(3:end) - 4.*F(2:end-1) + F(1:end-2)) ./ (2*stepSize));
err_backward = 100.*abs((Df(3:end) - dF_backward) ./ Df(3:end));

% % Centred divided difference
x_centred = x(3:end-2);
dF_centred = double((-F(5:end) + 8.*F(4:end-1) - 8.*F(2:end-3) + F(1:end-4)) ./ (12 * stepSize));
err_centred = 100.*abs((Df(3:end-2) - dF_centred) ./ Df(3:end-2));
%% 

% Display the results
plot(x,Df,'o-k','lineWidth',2);
hold all;
plot(x_forward,dF_forward,'d-r','lineWidth',2);
plot(x_backward,dF_backward,'s-g','lineWidth',2);
plot(x_centred,dF_centred,'*-b','lineWidth',2)
legend({'Analytical','Forward','Backward','Centred'},'location','northeast')


T = table(); % create an empty table

% Build a table
T.x = x';
T.df_dx = Df';

T.x_F = [x_forward,NaN,NaN]';
T.df_F = [dF_forward,NaN,NaN]';
T.epsilonT_F = [err_forward,NaN,NaN]';

T.x_B = [NaN,NaN,x_backward]';
T.df_B = [NaN,NaN,dF_backward]';
T.epsilonT_B = [NaN,NaN,err_backward]';

T.x_C = [NaN,NaN,x_centred,NaN,NaN]';
T.df_C = [NaN,NaN,dF_centred,NaN,NaN]';
T.epsilonT_C = [NaN,NaN,err_centred,NaN,NaN]';

% % Display the table
T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
T.Properties.VariableNames =  {'x','df_dx','x_F','df_F','epsilonT_F','x_B','df_B','epsilonT_B','x_C','df_C','epsilonT_C'}; % rename the columns to remove "Fun_" in the header
disp(T); % show the table in the command window

disp('___________________________________________________________________')


end

