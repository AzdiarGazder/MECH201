function L06E08_compareError_13_38_CompositeRules
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

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

for n = 3:99                      % define a number of points to plot
    x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values
                                  % between the bounds
    stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY**
                                  % spaced x-values between the bounds

    % % Applying Simpson's 1/3 Composite Rule:
    s13RArea = (stepSize/3) * (f(x(1)) + 4*sum(f(x(2:2:end-1))) + 2*sum(f(x(3:2:end-1)))  + f(x(end)));

    % % Applying Simpson's 3/8 Composite Rule:
    s38RArea = ((3*stepSize)/8) * (f(x(1)) + 2*sum(f(x(logical([0,(mod(2:length(x)-1,3)==1),0])))) +  3*sum(f(x(logical([0,(mod(2:length(x)-1,3)~=1),0])))) + f(x(end)));


    % % The error between the 2 methods
    err_13Int(n-2) = 100*abs((integratedArea - s13RArea) / integratedArea);
    err_38Int(n-2) = 100*abs((integratedArea - s38RArea) / integratedArea);
end

figure
plot(3:99,err_13Int,'o-r','lineWidth',1.5);
hold all
plot(3:99,err_38Int,'s-b','lineWidth',1.5)
legend({'1/3rd rule','3/8th rule'},'Location','northeast');
xlabel('Number of uniformly distributed points between xMin = 0 and xMax = 0.8');
ylabel('Error (%)');
legend()

end