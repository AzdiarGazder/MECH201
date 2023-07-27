function L01E10_myPolyfit
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
% 
%%


%%
clc; clear all; clear hidden; close all

tic
% Define some experimental data
x = [0.5 0.8 1.5 2.5 4];
y = [1.1 2.4 5.3 7.6 8.9];

% Plot the experimental data
plot(x,y,'or','LineWidth',2);
grid on;
hold all;


% Fit the curve using MATLAB built-in functions
P = polyfit(x,y,2);

% Plot the fitted curve
xx = min(x):0.1:max(x);
yy = polyval(P,xx);
plot(xx,yy,'-b','LineWidth',2);
hold off;
toc

end
