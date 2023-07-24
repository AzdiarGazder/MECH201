function L06E03_trapezoidalCompositeRule3_unequalWidths

clc; clear all; clear hidden; close all

% % Script modified from:
% % https://au.mathworks.com/matlabcentral/answers/364905-trapezoidal-numerical-integration-without-use-of-function

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

% define **UNEQUALLY** spaced x-values between the bounds
n = 100;            % define the number of points to plot
x = [xMin; sort((xMax - xMin).*rand(n-2,1) + xMin); xMax]; % generate a list of random points between the bounds

dx = diff(x); % since the widths vary for **UNEQUALLY** spaced x-values
              % between the bounds, we need to differentiate between points

% % MODIFIED APPROACH 2: The area of a trapezoid using scripting
% % Here the area of a trapezoid is defined as:
% % the varying trapezoid widths between pairs of points along the x-axis (or differential)
% % i.e. - (b - a)
% % 
% % multiplied by
% % 
% % the average of the trapezoid heights for each pair of points
% % (i.e. - (f(a) + f(b)) /2
% % 
trapArea2 = dot(dx, (f(x(1:end-1)) + f(x(2:end))) / 2);

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);

% % The error between the 2 methods
err = 100*abs((integratedArea - trapArea2) / integratedArea);

disp('___________________________________________________________________')
disp('For the trapezoidal rule, the area under the curve via:')
disp(['Scripting using modified Approach 2  = ',num2str(trapArea2)]);
disp(['MATLAB''s integrated area function    = ',num2str(integratedArea)]);
disp('----')
disp(['error (%)                            = ',num2str(err)]);
disp('___________________________________________________________________')

figure
plot(x,f(x(1:end)),'o-r','lineWidth',2)
legend('f(x)','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');

end
