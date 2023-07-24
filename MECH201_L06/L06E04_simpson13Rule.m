function L06E04_simpson13Rule

clc; clear all; clear hidden; close all

% % Script modified from:
% % https://au.mathworks.com/matlabcentral/fileexchange/72526-simpson-s-1-3-rule-composite

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

n = 2;                        % define the number of points to plot
x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values 
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY** 
                              % spaced x-values between the bounds

xx = x(2:end-1); % x-values in-between the bounds
sumPoints = 0;
for ii = 1: 1: length(xx)
    sumPoints = sumPoints + f(xx(ii));
end
sRArea = (stepSize/3) * (f(xMin) + 4*sumPoints + f(xMax));

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% % The error between the 2 methods
err = 100*abs((integratedArea - sRArea) / integratedArea);

disp('___________________________________________________________________')
disp('The area under the curve via:')
disp(['Scripting using Simpson''s 1/3 composite Rule  = ',num2str(sRArea)]);
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