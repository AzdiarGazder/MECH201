function L06E05_simpson13CompositeRule_multipleApplN

clc; clear all; clear hidden; close all

% % Script modified from:
% % https://au.mathworks.com/matlabcentral/fileexchange/72526-simpson-s-1-3-rule-composite

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

n = 4;                        % define a number of points to plot
x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values 
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY** 
                              % spaced x-values between the bounds


xx = x(2:end-1); % x-values in-between the bounds
sumOdd = 0;
sumEven = 0;
for ii = 1: length(xx) % for the in-between x-values
    % Adding +1 to the mod formula to find the even/odd numbred place of 
    % the in-between x-values in the actual x-value arrray
    if mod(ii+1,2) == 0 % for even numbered in-between x-values since the loop begins with the second x-value
       sumEven = sumEven + f(xx(ii));
    else % for odd numbered in-between x-values
       sumOdd = sumOdd + f(xx(ii));
    end
end
% Formula: (stepSize/3) * [f(1) +...
%                          4*(f(2) + f(4) + f(6)+...+ f(end-1)) +... %% sum of the function for the even numbered in-between x-values
%                          2*(f(3) + f(5) + f(7)+...+ f(end-1)) +... %% sum of the function for the odd numbered in-between x-values
%                          f(max)]
sRCArea = (stepSize/3) * (f(xMin) + 4*sumEven + 2*sumOdd + f(xMax));

% % The following command is the same as lines 20 to 36
% % Applying Simpson's 1/3 Composite Rule:
% % sRCArea = (stepSize/3) * (f(x(1)) + 4*sum(f(x(2:2:end-1))) + 2*sum(f(x(3:2:end-1)))  + f(x(end)))

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