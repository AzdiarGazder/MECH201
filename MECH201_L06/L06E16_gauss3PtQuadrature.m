function L06E16_gauss3PtQuadrature
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://math.stackexchange.com/questions/1796602/numerical-integration-in-matlab-gaussian-3-point-quadrature
%
%%


%%
clc; clear all; clear hidden; close all

f = @(x) x.^2 + 5.*x + 3; % define a function

% Define the interval [a, b]
xMin = 2; % define the lower bound
xMax = 6; % define the uppper bound


% f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function
% 
% xMin = 0;   % define the lower bound
% xMax = 0.8; % define the uppper bound


% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% I0 = 0;
for N = logspace(0,6,7)
    % Compute the final approximation using the interval scaling factor
    I_gQ = gaussq(f,xMin,xMax,N);
    
    err = 100*abs((integratedArea - I_gQ) / integratedArea); % for absolute error
%     err = 100*abs((I_gQ - I0) / I0); % for relative error
    if err < 1E-10
        break; % solution found
    end
    
%     I0 = I_gQ;
end

disp('___________________________________________________________________')
disp('The area under the curve via:')
disp(['Scripting using Gauss 3-pt quadrature                    = ',num2str(I_gQ)]);
disp(['MATLAB''s integrated area function                        = ',num2str(integratedArea)]);
disp('----')
disp(['error between Gauss 3-pt quadrature and integration (%)  = ',num2str(err)]);
disp('___________________________________________________________________')

end



function y = gaussq(f,xMin,xMax,N)
stepSize = (xMax - xMin) / N;
y = 0;
for ii = 1:N
    y = y + gauss3(f, xMin + (ii-1) * stepSize, xMin + ii*stepSize);
end
end


function t = gauss3(f,xMin,xMax)
j = (((xMin + xMax) / 2) - sqrt(3 / 5) * ((xMax - xMin) / 2));
k = (xMin + xMax) / 2;
l = (((xMin + xMax) / 2) + sqrt(3 / 5) * ((xMax - xMin) / 2));
t = ((xMax - xMin) / 18) * (5 * feval(f, j) + 8 * feval(f, k) + 5 * feval(f, l));
end


