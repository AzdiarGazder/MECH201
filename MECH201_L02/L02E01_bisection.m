function L02E01_bisection
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
% 
%%


%%
clc; clear all; clear hidden; close all

g = 9.81; % in m/(s^2)      = acceleration due to gravity
m = 68.1; % in kg = m1 + m2 = mass of parachutist + parachute
t = 10;   % in s            = time
v = 40;   % in m/s          = velocity
f = @(x) ((g*m)./x)*(1-exp(-(x./m)*t))-v; % = equation of motion

xL = 12;      % in kg/s
xR_old = xL;  % in kg/s
xU = 16;      % in kg/s

fxL = f(xL);
fxU = f(xU);

maxIter = 1000;    % maximum number of iterations
tol = 1E-4;        % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();


tic
if (fxL*fxU >= 0)
    disp('The function has a positive value at the end points of the interval.');
    disp('The root cannot be found using the bisection method. Please use another method.');
    return;
else

    % Main loop
    for iter = 1:maxIter

        xR = (xL+xU)/2;
        fxR = f(xR);
        err = abs((xR-xR_old)/xR);

        % Build a table within the main loop without preallocation
        tempTable.iter = iter;
        tempTable.xL = xL;
        tempTable.xR = xR;
        tempTable.xU = xU;
        tempTable.fxL = fxL;
        tempTable.fxR = fxR;
        tempTable.fxU = fxU;
        tempTable.err = err;
        T = [T;tempTable]; % append to table
        %---

        if fxR*fxU < 0 % the root lies in the upper sub-interval
            xL = xR;
            fxL = fxR;
        else           % the root lies in the lower sub-interval
            xU = xR;
            fxU = fxR;
        end

        if err <= tol % solution was found
            solNFound = true;
            x0 = xR;
            fx0 = fxR;
            break; % exit the loop
        end
        
        xR_old = xR;
    end
end

% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','xL','xR','xU','fxL','fxR','fxU','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Bisection converged in ',num2str(iter), ' iteration(s).'])
    disp(['Root = ',num2str(x0)]);
    disp(['Function value at root = ',num2str(fx0)]);
    disp('-------')

else % if no solution found
    error('No solution. Bisection did not converge in %d iteration(s).', maxIter);
end
toc

error = arrayfun(@(x) str2double(x), string(T.err));  % convert table columns to double array
plot(1:length(error),error,'o-k','LineWidth',2,'DisplayName',['bisection']);
hold all;
xlabel('iteration (s)')
ylabel('error (abs)')
legend('location','northeast')
hold off;

end