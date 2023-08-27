function L06E14_trapezoidalRule_rombergQuadrature
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/364905-trapezoidal-numerical-integration-without-use-of-function
%
%%

%%
clc; clear all; clear hidden; close all

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound


% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax)
disp('___________________________________________________________________')

T1 = table(); % create an empty table
tempTable1 = table();


figure;                                 % create a  figure
n = 100;                                % define the number of points to plot
x = linspace(xMin,xMax,n+1);            % define **EQUALLY** spaced
                                        % x-values between the bounds
plot(x,f(x(1:end)),'-k','lineWidth',2); % plot the function
hold all;
textLegend = {'f(x)'};                  % create a cell array for the
                                        % figure legend
clear x
n = 1:10; % define the number of intervals to apply the trapezoidal rule
for ii = 1:length(n) 

    % % APPROACH 2: The area of a trapezoid using scripting
    % % Here the area of a trapezoid is defined as:
    % % a small but constant width between pairs of points along the x-axis (or stepSize)
    % % i.e. - (b - a)
    % %
    % % multiplied by
    % %
    % % the average of the trapezoid heights for each pair of points
    % % (i.e. - (f(a) + f(b)) /2
    % %
    x = linspace(xMin,xMax,n(ii)+1);  % define **EQUALLY** spaced x-values
    % between the bounds
    stepSize = (xMax - xMin) / n(ii); % the width is the same for **EQUALLY**
    % spaced x-values between the bounds
    trapArea = sum(stepSize * (f(x(1:end-1)) + f(x(2:end))) / 2);

    % % The percent error between the integral and trapezoidal methods
    err1 = 100*abs((integratedArea - trapArea) / integratedArea);

    % Build a table within the main loop without preallocation
    tempTable1.n = n(ii);
    tempTable1.h = stepSize;
    tempTable1.I = trapArea;
    tempTable1.epsilonT1 = err1;
    T1 = [T1;tempTable1]; % append to table
    %---

    % Plot the trapezoidal data
    plot(x,f(x(1:end)),'-o','lineWidth',1.5);
    hold all;

    tempText = ['n = ',num2str(n(ii))];
    textLegend = [textLegend,  tempText];
end

legend(textLegend,'Location','northwest');
xlabel('X');
ylabel('Y = f(X)');
hold  off

% % Display the table
T1 = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T1); % set the number of decimal points to display in the table
T1.Properties.VariableNames =  {'n','h','I','epsilonT1'}; % rename the columns to remove "Fun_" in the header
disp(T1); % show the table in the command window


disp('___________________________________________________________________')
% Applying the Romberg Quadrature to the table T1 data
tableData = str2double(table2cell(T1)); % converting from table to cell to double
n = tableData(:,1); h = tableData(:,2); I = tableData(:,3); epsilonT = tableData(:,4);

% Finding the intervals that are double of each other [1, 2, 4, 8...]
h = h(ismember(n,mod(n,2)) | ismember(n,2.^n)); % look for even numbers that are also powers of 2
I = I(ismember(n,mod(n,2)) | ismember(n,2.^n));
epsilonT = epsilonT(ismember(n,mod(n,2)) | ismember(n,2.^n));
n = n(ismember(n,mod(n,2)) | ismember(n,2.^n)); % change n last

I_rQ = zeros(length(n),length(n));
err_rQ = zeros(length(n),length(n));
I_rQ(:,1) = I;
err_rQ(:,1) = epsilonT;

for col = 2:length(n)
    for ro = 1: length(n)-col+1
        I_rQ(ro,col) = ((4^(col-1) / (4^(col-1) - 1)) * I_rQ(ro + 1, col - 1)) - ...
            ((1 / (4^(col-1) - 1)) * I_rQ(ro, col - 1));
        
        err_rQ(ro,col) = 100*abs((integratedArea - I_rQ(ro,col)) / integratedArea);
    end
end
I_rQ
err_rQ


end
% %---------------------------------



