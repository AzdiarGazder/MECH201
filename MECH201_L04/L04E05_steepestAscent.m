function L04E05_steepestAscent
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% Define a function using MATLAB's symbolic toolbox
syms f(x, y)
f(x, y) = @(x, y) 2*x*y + 2*x - x^2 - 2*y^2;

% Calculate the partial derivatives of f with respect to x and y
df_dx = diff(f,x,1); % @(x, y) 2*y + 2 - 2*x;
df_dy = diff(f,y,1); % @(x, y) 2*x - 4*y;

% Set initial values for x and y
xOld = -1;
yOld = 1;
% Define a step size 
stepSize = 0.1;

maxIter = 1000;    % maximum number of iterations
tol = 1E-5;        % difference tolerance 
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

tic
% Main loop
for iter = 1:maxIter
    
    % Calculate the new x and y values using the steepest ascent method
    xNew = double(xOld + stepSize * df_dx(xOld, yOld));
    yNew = double(yOld + stepSize * df_dy(xOld, yOld));

    % Calculate the new value of f(x, y)
    fNew = double(f(xNew, yNew));

    % Calculate the error
    err = abs((double(f(xOld, yOld)) - fNew)/ double(f(xOld, yOld)));

    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.x = xNew;
    tempTable.y = yNew;
    tempTable.f = fNew;
    tempTable.err = err;

    T = [T;tempTable]; % append to table
    %---

    % Check for convergence
    if  err <= tol
        solNFound = true;
        xMax = double(xOld);
        yMax = double(yOld);
        fMax = double(f(xOld, yOld));
        break;
    end

    % Update the old x and y values
    xOld = xNew;
    yOld = yNew;
end


% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','x','y','f','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Steepest ascent method converged in ',num2str(iter), ' iteration(s).'])
    disp(['Xmax               = ',num2str(xMax)]);
    disp(['Ymax               = ',num2str(yMax)]);
    disp(['f @ (XMax, Ymax)   = ',num2str(fMax)]);
    disp('-------')

else % if no solution found
    error('No solution. Steepest ascent method did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.err));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['steepestAscent']);
hold all;
xlabel('iteration (s)')
ylabel('Error (abs)')
legend('location','northeast')
hold off;

end