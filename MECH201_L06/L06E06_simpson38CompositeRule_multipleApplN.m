function L06E06_simpson38CompositeRule_multipleApplN

clc; clear all; clear hidden; close all

% % Script modified from:
% % https://au.mathworks.com/matlabcentral/fileexchange/72562-simpson-s-3-8-rule-composite

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

n = 3;                      % define a number of points to plot
x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY**
                              % spaced x-values between the bounds


xx = x(2:end-1); % x-values in-between the bounds
sumMult3 = 0;
sumNOTMult3 = 0;
for ii = 1: length(xx) % for the in-between x-values
    % Adding +1 to the mod formula to find the even/odd numbred place of
    % the in-between x-values in the actual x-value arrray
    if mod(ii+1,3) == 0 % for terms that are multiples of 3
       sumMult3 = sumMult3 + f(xx(ii)); % sum of terms that are multiples of 3
    else % for terms that are NOT multiples of 3
     sumNOTMult3 = sumNOTMult3 + f(xx(ii)); % sum of terms that are NOT multiples of 3
    end
end
 % Formula:  (3h/8)*[(f(1) +...
 %                   2*(f(3) + f(6) +...+ f(n-3)) +....
 %                   3*(f(1) + f(2) + f(4) + f(5) +...+ f(n-2) + f(n-1)) +....
 %                   f(n))]
s38RArea = ((3*stepSize)/8) * (f(xMin) + 3*sumMult3 + 3*sumNOTMult3 + f(xMax));

% % The following command the same as lines 20 to 36
% % Applying Simpson's 3/8 Rule:
% % s38RArea = ((3*stepSize)/8) * (sum(f(x(1:3:end-3))) +  3*sum(f(x(2:3:end-2))) + 3*sum(f(x(3:3:end-1))) + sum(f(x(4:3:end))));
% % The second bracket comprisies the terms:
%    [sum(f(1) + f(4) + f(7)  +...+ f(end-3)) +...
% 3 * sum(f(2) + f(5) + f(8)  +...+ f(end-2)) +...
% 3 * sum(f(3) + f(6) + f(9)  +...+ f(end-1)) +...
%     sum(f(4) + f(7) + f(10) +...+ f(end))]

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