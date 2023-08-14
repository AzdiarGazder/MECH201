function L04E03_parabolicInterpolation
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://drive.google.com/drive/folders/1mYNSwz3R7y4M5fSc37cr0z1LvleANIrM
%
%%


%%
clc; clear all; clear hidden; close all

% Define a function using MATLAB's symbolic toolbox
syms f(x)
f(x) = @(x) 2.*sin(x) - (x.^2./10);     % define a function

x0 = 0;
x1 = 1;
x2 = 4;
x3_old = 0;


maxIter = 1000;    % maximum number of iterations
tol = 1E-7;        % tolerance
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

tic
% Main loop
for iter = 1:maxIter
   
    % Calculate fx0, fx1, and fx2
    fx0 = double(f(x0)); 
    fx1 = double(f(x1));
    fx2 = double(f(x2));

    % Calculate x3 and fx3
    x3 = ((fx0 * (x1^2 - x2^2)) + (fx1 * (x2^2 - x0^2)) + (fx2 * (x0^2 - x1^2))) /...
        ((2*fx0 * (x1 - x2)) + (2*fx1 * (x2 - x0)) + (2*fx2 * (x0 - x1)));
    fx3 = double(f(x3));

    % Calculate the error
    err = abs((x3 - x3_old) / x3);

    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.x0 = x0;
    tempTable.fx0 = fx0;
    tempTable.x1 = x1;
    tempTable.fx1 = fx1;
    tempTable.x2 = x2;
    tempTable.fx2 = fx2;
    tempTable.x3 = x3;
    tempTable.fx3 = fx3;
    tempTable.err = err;

    T = [T;tempTable]; % append to table
    %---

    if err <= tol % solution was found
        solNFound = true;
        xMax = x3;
        fMax = fx3;
        
        break; % exit the loop
    end

    % Redefine x0, x1, x2, x3 for the next iteration
    if x3 >= x1 
        x0 = x1;
        x1 = x3;
        x2 = x2;
    else
        x0 = x0;
        x2 = x1;
        x1 = x3;
    end

    x3_old = x3;
    x3 = [];
end


% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','x0','fx0','x1','fx1','x2','fx2','x3','fx3','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Parabolic interpolation converged in ',num2str(iter), ' iteration(s).'])
    disp(['Xmax     = ',num2str(xMax)]);
    disp(['f @ Xmax = ',num2str(fMax)]);
    disp('-------')

else % if no solution found
    error('No solution. Parabolic interpolation did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.err));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['parabolicInterpolation']);
hold all;
xlabel('iteration (s)')
ylabel('Error (abs)')
legend('location','northeast')
hold off;

end