function L06E06_simpson38Rule
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/72562-simpson-s-3-8-rule-composite
%
%%


%%
clc; clear all; clear hidden; close all

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

%% USER PLEASE NOTE !!!
n = 3;                        % define the number of points to plot
                              % FOR THE LECTURE NOTES n = 3 CASE ONLY
%% 

x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY**
                              % spaced x-values between the bounds


sumMult3 = 0;
sumNOTMult3 = 0;
% NOTE: In the lecture notes x-values = x0, x1, ...., xn
for ii = 2: length(x)-1 % for the in-between x-values
    if mod(ii-1,3) ~= 0 % for terms that are NOT multiples of 3
       sumNOTMult3 = sumNOTMult3 + f(x(ii)); % sum of terms that are NOT multiples of 3
    else % for terms that are multiples of 3
     sumMult3 = sumMult3 + f(x(ii)); % sum of terms that are multiples of 3
    end
end
s38RArea = ((3*stepSize)/8) * (f(xMin) + 3*sumMult3 + 3*sumNOTMult3 + f(xMax));

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% % The error between the 2 methods
err = 100*abs((integratedArea - s38RArea) / integratedArea);

disp('___________________________________________________________________')
disp('The area under the curve via:')
disp(['Scripting using Simpson''s 3/8 Rule    = ',num2str(s38RArea)]);
disp(['MATLAB''s integrated area function     = ',num2str(integratedArea)]);
disp('----')
disp(['error (%)                             = ',num2str(err)]);
disp('___________________________________________________________________')

figure
plot(x,f(x(1:end)),'o-r','lineWidth',2)
legend('f(x)','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');


end