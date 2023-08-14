function L04E07_linearProgramingFormulation_matlabDefault
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% Objective function coefficients
% % Z = 150.*x + 175.*y
f = [-150, -175]; % Since the objective function in linprog is minimized, use negative values.

% % Given the constraints:
% %  7*x + 11*y <= 77;
% % 10*x +  8*y <= 80;
% %    x        <=  9;
% %    x        >=  0;
% %           y <=  6;
% %           y >=  0;

% Inequality constraint matrix
ineqConstrMatrix = [7, 11;...
    10, 8;...
    1, 0;...
    0, 1];

% Inequality constraint values
ineqConstrValues = [77;...
    80;...
    9;...
    6];

% Lower bounds for x and y
xyL = [0;...
    0];

% Upper bounds for x and y
xyU = [9;...
    6];


% Addding the slack variables
f = [f, zeros(1,size(ineqConstrMatrix,1))];
ineqConstrMatrix = [ineqConstrMatrix, eye(size(ineqConstrMatrix,1))];
xyL = [xyL; zeros(size(ineqConstrMatrix,1),1)];
xyU = [xyU; zeros(size(ineqConstrMatrix,1),1)];

tic
% Solve the linear programing problem using MATLAB's default functions
[xyOptimal, fval, exitflag, output] = linprog(f, ineqConstrMatrix, ineqConstrValues, [], [], xyL, xyU);

% Display the results
if exitflag == 1
    disp('-------')
    disp(output)
    disp('-------')

    disp(['X_optimal            = ',num2str(xyOptimal(1))]);
    disp(['Y_optimal            = ',num2str(xyOptimal(2))]);
    disp(['Maximum value of Z   = ',num2str(-fval)]); % Since the objective function in linprog is minimized, use the negative to get the maximum value.
    disp('-------')

else
    disp('-------')
    disp('Optimisation failed.');
    disp('-------')
end
toc


% end
