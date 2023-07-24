function L02E04_newtonRaphson

clc; clear all; clear hidden; close all

%% Define a function
% % f(x) = exp(-x) - x = 0
% Method 1: Using MATLAB's symbolic toolbox
syms f(x)
f(x) = @(x) exp(-x) - x;
fPrime = diff(f(x)); % Differentiate the function
% % Method 2: Using only MATLAB's anonymous fuctions
% f = @(x) exp(-x) - x;
% fPrime = str2func(['@(x) ',...
%     char(diff(str2sym(regexprep(char(f),'^@\(x\)',''))))]); % Differentiate the function
x0 = 0; % initial guess


maxIter = 1000;    % maximum number of iterations
tol = 1E-4;        % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

% Main loop
tic
for iter = 1:maxIter
    f_val = double(subs(f,x0));
    fP_val = double(subs(fPrime,x0));
    xi = x0 - (f_val/fP_val);
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
    disp(['Newton-Raphson converged in ',num2str(iter), ' iteration(s).'])
    disp(['Root = ',num2str(x0)]);
    disp('-------')

else % if no solution found
    error('No solution. Newton-Raphson did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.err));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['Newton-Raphson']);
hold all;
xlabel('iteration (s)')
ylabel('error (abs)')
legend('location','northeast')
hold off;

end
