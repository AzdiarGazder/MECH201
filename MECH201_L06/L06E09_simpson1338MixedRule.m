function L06E09_simpson1338MixedRule
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/72526-simpson-s-1-3-rule-composite
% https://au.mathworks.com/matlabcentral/fileexchange/72562-simpson-s-3-8-rule-composite
%
%%


%%
clc; clear all; clear hidden; close all

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

n = 5;                        % define a number of points to plot
x = linspace(xMin,xMax,n+1)  % define **EQUALLY** spaced x-values
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY**
                              % spaced x-values between the bounds

% % Sub-dividing the data points into 2 arrays
x13 = x(1: 3*floor(n/3))  % taking the number of points that correpond to the lowest multiple of 3
x38 = x(3*floor(n/3): end)

% % Applying Simpson's 1/3 Composite Rule to the first array
s13RArea = (stepSize/3) * (f(x13(1)) + 4*sum(f(x13(2:2:end-1))) + 2*sum(f(x13(3:2:end-1)))  + f(x13(end)));

% % Applying Simpson's 3/8 Composite Rule to the second array
s38RArea = ((3*stepSize)/8) * (f(x38(1)) + 2*sum(f(x38(logical([0,(mod(2:length(x38)-1,3)==1),0])))) +  3*sum(f(x38(logical([0,(mod(2:length(x38)-1,3)~=1),0])))) + f(x38(end)));

totalArea = s13RArea + s38RArea;

% % Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% % The error between the 2 methods
err = 100*abs((integratedArea - totalArea) / integratedArea);

disp('___________________________________________________________________')
disp('The area under the curve via:')
disp(['Scripting using Simpson''s 1/3 and 3/8 Mixed Rule    = ',num2str(totalArea)]);
disp(['MATLAB''s integrated area function                   = ',num2str(integratedArea)]);
disp('----')
disp(['error (%)                                           = ',num2str(err)]);
disp('___________________________________________________________________')

figure
plot(x,f(x(1:end)),'o-r','lineWidth',2)
legend('f(x)','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');

end