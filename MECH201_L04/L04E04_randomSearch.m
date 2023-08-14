function L04E04_randomSearch
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/38630-random-search-algorithm?s_tid=srchtitle
% https://www.lara.on.ca/~nshammas/MATLAB/Optim_RandSearch1.htm
%
%%


%%
clc; clear all; clear hidden; close all

% Define a function using MATLAB's symbolic toolbox
syms f(x, y)
f(x, y) = @(x, y) y - x - 2.*x.^2 - 2.*x.*y - y.^2;     % define a function

xL = -2; % lower x bound
xU =  2; % upper x bound

yL = 1; % lower y bound
yU = 3; % upper y bound

% Set initial values
fMax = -inf;
xMax = 0;
yMax = 0;

maxIter = 1E3:2E3:1E4;    % maximum number of iterations
                          % also corresponds to the number of random samples

for mI = 1:length(maxIter)

    solNFound = false; % flag for solution

    tic
    % Main loop for random search
    for iter = 1:maxIter(mI)
        % Generate random x and y values within the specified range
        xRandom = xL + ((xU - xL) * rand());
        yRandom = yL + ((yU - yL) * rand());

        % Evaluate the function at the current x, y
        fRandom = double(f(xRandom, yRandom));

        % Check if the current value is greater than the current maximum
        if fRandom > fMax
            solNFound = true;
            fMax = fRandom;
            xMax = xRandom;
            yMax = yRandom;
        end
    end


    % Display the results
    if solNFound % if solution found
        disp('-------')
        disp('Solution found.')
        disp(['Random search algorithm (RSA) in ',num2str(iter), ' iteration(s).'])
        disp(['Xmax               = ',num2str(xMax)]);
        disp(['Ymax               = ',num2str(yMax)]);
        disp(['f @ (XMax, Ymax)   = ',num2str(fMax)]);
        disp('-------')

    else % if no solution found
        warning('No solution. Random search algorithm (RSA) did not find a solution in %d iteration(s).', maxIter(mI));
    end
    toc
end

end