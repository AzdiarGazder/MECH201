function L07E04_taylorSeriesExpansion_2ndDerivative_highAccuracy
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
f(x) = -0.1.*x.^4 -0.15.*x.^3 -0.5.*x.^2 -0.25.*x +1.2

% step sizes
stepSize = 0.05;

% x-values for which derivatives require calculation
x = linspace(0,1,(1/stepSize)+1);

% Analytical solution
d2f_dx2 = diff(f,2)
D2f = double(d2f_dx2(x));
disp('___________________________________________________________________')


%% Taylor series expansion (2nd order approximation)
F = f(x); % to enable the replacing of different x values into the equation 

% % Centred divided difference
x_centred = x(3:end-2);
d2F_centred = double((-F(5:end) + 16.*F(4:end-1) - 30.*F(3:end-2) + 16.*F(2:end-3) - F(1:end-4)) ./ (12*stepSize^2));
err_centred = 100.*abs((D2f(3:end-2) - d2F_centred) ./ D2f(3:end-2));
%% 

% Display the results
plot(x,D2f,'o-k','lineWidth',2);
hold all;
plot(x_centred,d2F_centred,'*-b','lineWidth',2)
legend({'Analytical','Centred'},'location','northeast')


T = table(); % create an empty table

% Build a table
T.x = x';
T.df_dx = D2f';

T.d2f_C = [NaN,NaN,d2F_centred,NaN,NaN]';
T.epsilonT_C = [NaN,NaN,err_centred,NaN,NaN]';

% % Display the table
T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
T.Properties.VariableNames =  {'x','d2f_dx2','d2f_C','epsilonT_C'}; % rename the columns to remove "Fun_" in the header
disp(T); % show the table in the command window

disp('___________________________________________________________________')


end

