function L04E02_goldenSection
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
syms f(x)
f(x) = @(x) 2.*sin(x) - (x.^2./10);     % define a function

xL = 0; % lower bound
xR_old = xL;
xU = 4; % upper bound


maxIter = 1000;    % maximum number of iterations
diffTol = 1E-7;    % difference tolerance 
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

tic
% Main loop
for iter = 1:maxIter
    
    fxL = double(f(xL));
    fxU = double(f(xU));

    d = ((sqrt(5) - 1)/2) * (xU - xL);

    x1 = xL + d;
    x2 = xU - d;

    fx1 = double(f(x1));
    fx2 = double(f(x2));
    
    if fx1 > fx2
        xL = x2;
    elseif fx1 < fx2
        xU = x1;
    end

    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.xL = xL;
    tempTable.fxL = fxL;
    tempTable.x2 = x2;
    tempTable.fx2 = fx2;
    tempTable.x1 = x1;
    tempTable.fx1 = fx1;
    tempTable.xU = xU;
    tempTable.fxU = fxU;
    tempTable.d = d;

    T = [T;tempTable]; % append to table
    %---

    if abs(xU - xL) <= diffTol % solution was found
        solNFound = true;
        if fx1 > fx2
            xMax = x1;
            fMax = fx1;
        else
            xMax = x2;
            fMax = fx2;
        end
        break; % exit the loop
    end

end


% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','xL','fxL','x2','fx2','x1','fx1','xU','fxU','d'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Golden section converged in ',num2str(iter), ' iteration(s).'])
    disp(['Xmax     = ',num2str(xMax)]);
    disp(['f @ Xmax = ',num2str(fMax)]);
    disp('-------')

else % if no solution found
    error('No solution. Golden section did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.d));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['goldenSection']);
hold all;
xlabel('iteration (s)')
ylabel('Difference (abs)')
legend('location','northeast')
hold off;

end