function L06E15_gauss2PtQuadrature
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% Define the function
f = @(x) x.^2 + 5.*x + 3;

% Define the interval [a, b]
xMin = 2; % define the lower bound
xMax = 6; % define the uppper bound

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% Gauss nodes and weights for 2-point Gauss quadrature
nodes = [-sqrt(1/3), sqrt(1/3)];  % Gauss nodes
weights = [1, 1];                 % Gauss weights

% Initialise the sum for the quadrature approximation
sumQuadrature = 0;

% Perform 2 point Gauss quadrature
for ii = 1:length(nodes)
    Xi = 0.5 * (xMax - xMin) * nodes(ii) + 0.5 * (xMax + xMin);  % Map nodes to the interval [a, b]
    sumQuadrature = sumQuadrature + weights(ii) * f(Xi);
end

% Compute the final approximation using the interval scaling factor
I_gQ = 0.5 * (xMax - xMin) * sumQuadrature;

err = 100*abs((integratedArea - I_gQ) / integratedArea); % for absolute error


disp('___________________________________________________________________')
disp('The area under the curve via:')
disp(['Scripting using Gauss 2-pt quadrature                    = ',num2str(I_gQ)]);
disp(['MATLAB''s integrated area function                        = ',num2str(integratedArea)]);
disp('----')
disp(['error between Gauss 3-pt quadrature and integration (%)  = ',num2str(err)]);
disp('___________________________________________________________________')

end

