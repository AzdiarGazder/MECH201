function L06E05_simpson13CompositeRule_multipleApplN
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/72526-simpson-s-1-3-rule-composite
%
%%


%%
clc; clear all; clear hidden; close all

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

n = 4;                        % define a number of points to plot
x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values 
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY** 
                              % spaced x-values between the bounds


sumOdd = 0;
sumEven = 0;
% NOTE: In the lecture notes x-values = x0, x1, ...., xn
for ii = 2: length(x)-1 % using only the in-between x-values
    if mod(ii-1,2) ~= 0 % for odd numbered in-between x-values (NOTE: the loop begins with the 2nd x-value = x1)
       sumOdd = sumOdd + f(x(ii));
    else % for even numbered in-between x-values
       sumEven = sumEven + f(x(ii));
    end
end
% Formula: (stepSize/3) * [f(x0) +...
%                          4*(f(x1) + f(x3) + f(x5)+...+ f(xend-1)) +... %% sum of the function for the odd numbered in-between x-values
%                          2*(f(x2) + f(x4) + f(x6)+...+ f(xend-2)) +... %% sum of the function for the even numbered in-between x-values
%                          f(xn)]
sRCArea = (stepSize/3) * (f(x(1)) + 4*sumOdd + 2*sumEven + f(x(end)));

% The following command is the same as lines 30 to 44
% Applying Simpson's 1/3 Composite Rule:
% sRCArea = (stepSize/3) * (f(x(1)) + 4*sum(f(x(2:2:end-1))) + 2*sum(f(x(3:2:end-1)))  + f(x(end)))

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% % The error between the 2 methods
err = 100*abs((integratedArea - sRCArea) / integratedArea);

disp('___________________________________________________________________')
disp('The area under the curve via:')
disp(['Scripting using Simpson''s 1/3 Composite Rule  = ',num2str(sRCArea)]);
disp(['MATLAB''s integrated area function             = ',num2str(integratedArea)]);
disp('----')
disp(['error (%)                                     = ',num2str(err)]);
disp('___________________________________________________________________')

figure
plot(x,f(x(1:end)),'o-r','lineWidth',2)
legend('f(x)','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');


end