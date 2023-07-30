% function L04E04_randomNumberMaximum
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/25919-golden-section-method-algorithm
%
%%


%%
clc; clear all; clear hidden; close all

% Define a function using MATLAB's symbolic toolbox
syms f(x, y)    
f = @(x, y) y - x - 2*x*x - 2*x*y - y*y;

    % Define the range for x and y values
    xL = -2;
    xU = 2;
    yL = 1;
    yU = 3;

    % Number of random samples
    maxIter = 1000;

    % Initialize maximum values and corresponding x, y coordinates
    fMax = -inf;
    xMax = 0;
    yMax = 0;

    % Perform random search
    for iter = 1:maxIter
        % Generate random x and y values within the specified range
        xRandom = (xU - xL) * rand() + xL;
        yRandom = (yU - yL) * rand() + yL;

        % Evaluate the function at the current x, y
        fRandom = f(xRandom, yRandom);

        % Check if the current value is greater than the current maximum
        if fRandom > fMax
            fMax = fRandom;
            xMax = xRandom;
            yMax = yRandom;
        end
    end
iter
    % Display the results
    fprintf('Maximum value of f(x, y) = %.4f\n', fMax);
    fprintf('Optimal x = %.4f\n', xMax);
    fprintf('Optimal y = %.4f\n', yMax);

%     % Return the results
%     xU = x_opt;
%     yU = y_opt;
% end
