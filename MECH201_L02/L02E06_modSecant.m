function L02E06_modSecant

clc; clear all; clear hidden; close all

%% Define a function
% % f(x) = exp(-x) - x = 0
% Method 1: Using MATLAB's symbolic toolbox
syms f(x)
f(x) = @(x) exp(-x) - x;
% % Method 2: Using MATLAB's anonymous fuctions
% f = @(x) exp(-x);


x0 = 1; % initial guesses
xDelta = 0.01;

maxIter = 1000;    % maximum number of iterations
tol = 1E-12;       % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

% Main loop
tic
for iter = 1:maxIter
    fx0 = double(subs(f,x0)); % the value of the function at x0
    x0plusxDelta = x0 + xDelta;
    fx0plusxDelta = double(subs(f,x0plusxDelta)); % the value of the function at (x0 + xDelta)
    xi = x0 - (xDelta * fx0)/(fx0plusxDelta - fx0);
    err = abs((xi-x0)/xi);

    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.x0 = x0;
    tempTable.x0plusxDelta = x0plusxDelta;
    tempTable.xi = xi;
    tempTable.fx0 = fx0;
    tempTable.fx0plusxDelta = fx0plusxDelta;
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
    T.Properties.VariableNames =  {'iter','x0','x0plusxDelta','xi','fx0','fx0plusxDelta','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Modified secant converged in ',num2str(iter), ' iteration(s).'])
    disp(['Root = ',num2str(x0)]);
    disp(['f(x) at root = ', num2str(double(f(x0)))]);
    disp('-------')

else % if no solution found
    error('No solution. Modified secant did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.err));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['modified secant']);
hold all;
xlabel('iteration (s)')
ylabel('error (abs)')
legend('location','northeast')
hold off;

end
