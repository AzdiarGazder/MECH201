function L01E02_quadEq_numSolN2
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
% 
%%


%%
clc; clear all; clear hidden; close all

x = 1;
x_old = x;

maxIter = 20;      % maximum number of iterations
tol = 1E-4;        % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

% Main loop
tic
for iter = 1:maxIter
    x_new = exp(-x);
    err = abs((x_new-x_old)/x_new);
    
    x_old = x;
    x = x_new;

    % build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.x_old = x_old;
    tempTable.x_new = x_new;
    tempTable.err = err;
    T = [T;tempTable]; % append to table
    %---

    if err <= tol % solution found
        solNFound = true;
        x0 = x_old;
        break; % exit the loop
    end
end

% display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',4)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','x_old','x_new','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['The quadratic equation converged in ',num2str(iter), ' iteration(s).'])
    disp(['x = ',num2str(x0)]);
    disp('-------')

else % if no solution found
    error('No solution. The quadratic equation did not converge in %d iteration(s).', maxIter);
end
toc

end
