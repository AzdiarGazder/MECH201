function L06E13_trapezoidalRule_richardsonExtrapolation
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


% % Given the 4 equations:
% % I = I(h1) + E(h1) = I(h2) + E(h2)           -- Eq (1)
% % E(h1) = -((b-a)/12) * h1^2 * f_bar''        -- Eq (2)
% % E(h2) = -((b-a)/12) * h2^2 * f_bar''        -- Eq (3)
% % E(h1) / E(h2) = h1^2 / h2^2                 -- Eq (4)
% % 
% % Show that:
% % E(h2) = (I(h1) - I(h2)) / (1 - (h1^2/h2^2)) ...The first proof
% % 
% % and
% % 
% % I = I(h2) + (I(h2) - I(h1)) /  ((h1/h2)^2 - 1) ...The second proof
% % 
% % Step 1: Substitute E(h1) and E(h2) from Eqs. (2) and (3) into Eq. (1)
% % I(h1) + -((b-a)/12) * h1^2 * f_bar'' = I(h2) + -((b-a)/12) * h2^2 * f_bar''
% % 
% % Step 2: Move the I(h1) & I(h2) terms to the RHS and the other terms to the LHS and then flip
% % I(h2) - I(h1) = ((b-a)/12) * h2^2 * f_bar'' -((b-a)/12) * h1^2 * f_bar''
% % 
% % Step 3: Factor out ((b-a)/12) * f_bar'' from the RHS
% % I(h2) - I(h1) = ((b-a)/12) * f_bar'' * (h2^2 - h1^2)
% % 
% % Step 4: Relocating the terms such that
% % ((b-a)/12) * f_bar'' = (I(h2) - I(h1)) / (h2^2 - h1^2)
% % 
% % Step 5: Now, substitute Step 4 into Eq (3)
% % E(h2) = -((I(h2) - I(h1)) / (h2^2 - h1^2)) * h2^2
% % 
% % Step 6: Relocating the minus sign into the bracket in the numerator
% % E(h2) = ((I(h1) - I(h2)) / (h2^2 - h1^2)) * h2^2 
% % 
% % Step 7: Putting all numerator terms together
% % E(h2) = ((I(h1) - I(h2)) * h2^2) /  (h2^2 - h1^2) 
% % 
% % Step 8: The denominator can also be expressed as
% % E(h2) = ((I(h1) - I(h2)) * h2^2) /  (h2^2 * (1 - (h1^2 /h2^2)))
% % 
% % Step 9: Cancelling out the h2^2 term in the numerator and denominator results in
% % E(h2) = (I(h1) - I(h2)) /  (1 - (h1^2 /h2^2)) ...The first proof
% % 
% % Step 10: Substitute Step 9 into the 3rd part of Eq. (1)
% % I = I(h2) + (I(h1) - I(h2)) /  (1 - (h1^2 /h2^2)) 
% % 
% % Step 11: Multiplying numerator and denominator of the second term with -1 results in 
% % I = I(h2) + (I(h2) - I(h1)) /  ((h1/h2)^2 - 1) ...The second proof


%%
clc; clear all; clear hidden; close all

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

% Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);
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
n = [1 2 4]; % define the number of intervals to apply the trapezoidal rule
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
% Applying Richardson's extrapolation to the table T1 data
tableData = str2double(table2cell(T1)); % converting from table to cell to double
n = tableData(:,1); h = tableData(:,2); I = tableData(:,3); epsilonT = tableData(:,4);

T2 = table(); % create an empty table
tempTable2 = table();

for ii = 1:length(n)-1
    I_re = (4/3 * I(ii+1)) - (1/3 * I(ii));
    err2 = 100*abs((integratedArea - I_re) / integratedArea);

    % Build a table within the main loop without preallocation
    tempTable2.n = n(ii);
    tempTable2.h = h(ii);
    tempTable2.I_re = I_re;
    tempTable2.epsilonT2 = err2;
    T2 = [T2;tempTable2]; % append to table
    %---
end

% % Display the table
T2 = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T2); % set the number of decimal points to display in the table
T2.Properties.VariableNames =  {'n','h','I_re','epsilonT2'}; % rename the columns to remove "Fun_" in the header
disp(T2); % show the table in the command window

end

