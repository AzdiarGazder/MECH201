function L04E01_newton
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgments:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/85735-newton-s-method-newtons_method
% 
%%


%%
clc; clear all; clear hidden; close all

% Define a function using MATLAB's symbolic toolbox
syms f(x)
f(x) = @(x) 2.*sin(x) - (x.^2./10)  % define a function
fPrime = diff(f(x),1)                 % first-order differential
fdoublePrime = diff(f(x),2)         % second-order differential

xMax = 2.5; % initial guess


maxIter = 1000;    % maximum number of iterations
tol = 1E-5;        % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

% Main loop
tic
for iter = 1:maxIter
    
    f_value = double(subs(f,xMax));
    fP_value = double(subs(fPrime,xMax));
    fdP_value = double(subs(fdoublePrime,xMax));
    
    xi = xMax - (fP_value/fdP_value);

    % Calculate the error
    err = abs((xi-xMax) / xi);

    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.x0 = xMax;
    tempTable.f = f_value;
    tempTable.fP = fP_value;
    tempTable.fdP = fdP_value;
    tempTable.err = err;
    T = [T;tempTable]; % append to table
    %---

    if err <= tol % solution was found
        solNFound = true;
        xMax = xi;
        fMax = f_value;
        break;
    end

    xMax = xi;
end

% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','x0','f','fP','fdP','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Newton''s method converged in ',num2str(iter), ' iteration(s).'])
    disp(['Xmax     = ',num2str(xMax)]);
    disp(['f @ Xmax = ',num2str(fMax)]);
    disp('-------')

else % if no solution found
    error('No solution. Newton''s method did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.err));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['Newton''s method']);
hold all;
xlabel('iteration (s)')
ylabel('error (abs)')
legend('location','northeast')
hold off;

end
