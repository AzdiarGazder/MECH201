function L06E10_midpointRule
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/1586164-how-to-plot-midpoint-method
%
%%


%%
clc; clear all; clear hidden; close all

f = @(x)  0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

n = 100;                      % define a number of points to plot
x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY**
                              % spaced x-values between the bounds

midpointArea = 0;
for ii = 1:n
    midPointX(ii) = (x(ii) + (x(ii) + stepSize)) / 2; % generate the list of midpoints
    midpointArea = midpointArea + (stepSize * f(midPointX(ii))); % sum the area of the midpoints
end

% % Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% % The error between the 2 methods
err = 100*abs((integratedArea - midpointArea) / integratedArea);

disp('___________________________________________________________________')
disp('The area under the curve via:')
disp(['Scripting using the midpoint rule    = ',num2str(midpointArea)]);
disp(['MATLAB''s integrated area function    = ',num2str(integratedArea)]);
disp('----')
disp(['error (%)                            = ',num2str(err)]);
disp('___________________________________________________________________')

figure
plot(midPointX,f(midPointX(1:end)),'o-r','lineWidth',2)
legend('f(midPointX)','Location','southeast');
xlabel('midPointX');
ylabel('Y = f(midPointX)');


end

