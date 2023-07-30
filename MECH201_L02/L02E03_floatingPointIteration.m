function L02E03_floatingPointIteration
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
% 
%%


%%
clc; clear all; clear hidden; close all

%% Define a function
% % f(x) = exp(-x) - x = 0
% % Or, x - exp(-x) = 0;
% % Or, x = exp(-x)
f = @(x) exp(-x);
x0 = 0; % initial guess


maxIter = 1000;    % maximum number of iterations
tol = 1E-4;        % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

% Main loop
tic
for iter = 1:maxIter
    xi = f(x0);
    err = abs((xi-x0)/xi);

    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.x0 = x0;
    tempTable.xi = xi;
    tempTable.err = err;
    T = [T;tempTable]; % append to table
    %---

    if err <= tol % solution was found
        solNFound = true;
        x0 = xi;
        break;
    end

    x0 = xi;
end

% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','x0','xi','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Floating point iteration converged in ',num2str(iter), ' iteration(s).'])
    disp(['Root = ',num2str(x0)]);
    disp('-------')

else % if no solution found
    error('No solution. Floating point iteration did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.err));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['floating point iteration']);
hold all;
xlabel('iteration (s)')
ylabel('error (abs)')
legend('location','northeast')
hold off;

end
