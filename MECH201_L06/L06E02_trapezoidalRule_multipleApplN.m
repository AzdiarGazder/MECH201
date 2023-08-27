function L06E02_trapezoidalRule_multipleApplN
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/364905-trapezoidal-numerical-integration-without-use-of-function
%
%%


%% 
clc; clear all; clear hidden; close all

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

T = table(); % create an empty table
tempTable = table();


figure;                                 % create a  figure
n = 100;                                % define the number of points to plot
x = linspace(xMin,xMax,n+1);            % define **EQUALLY** spaced 
                                        % x-values between the bounds
plot(x,f(x(1:end)),'-k','lineWidth',2); % plot the function
hold all;
textLegend = {'f(x)'};                  % create a cell array for the 
                                        % figure legend
clear x
for n = 2:10 % define the number of intervals to apply the trapezoidal rule

    % % The area of a trapezoid using scripting
    % % Here the area of a trapezoid is defined as:
    % % a small but constant width between pairs of points along the x-axis (or stepSize)
    % % i.e. - (b - a)
    % %
    % % multiplied by
    % %
    % % the average of the trapezoid heights for each pair of points
    % % (i.e. - (f(a) + f(b)) /2
    % %
    x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values
                                  % between the bounds
    stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY**
                                  % spaced x-values between the bounds
    trapArea2 = sum(stepSize * (f(x(1:end-1)) + f(x(2:end))) / 2);


    % % The percent error between the integral and trapezoidal methods
    err = 100*abs((integratedArea - trapArea2) / integratedArea);

    % Build a table within the main loop without preallocation
    tempTable.n = n;
    tempTable.h = stepSize;
    tempTable.I = trapArea2;
    tempTable.epsilonT = err;
    T = [T;tempTable]; % append to table
    %---
    
    % Plot the trapezoidal data
    plot(x,f(x(1:end)),'-o','lineWidth',1.5);
    hold all;

    tempText = ['n = ',num2str(n)];
    textLegend = [textLegend,  tempText];
end

legend(textLegend,'Location','northwest');
xlabel('X');
ylabel('Y = f(X)');
hold  off

% % Display the table
T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
T.Properties.VariableNames =  {'n','h','I','epsilonT'}; % rename the columns to remove "Fun_" in the header
disp(T); % show the table in the command window


end
