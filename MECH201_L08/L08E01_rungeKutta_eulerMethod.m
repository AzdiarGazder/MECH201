function L08E01_rungeKutta_eulerMethod
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%% 
clc; clear all; clear hidden; close all

syms f(x,y)
f(x,y) = -2.*x.^3 + 12.*x.^2 - 20.*x + 8.5 + 0.3.*y; % define a function
% f(x,y) = 4.*exp(0.8.*x) - 0.5.*y; 

xMin = 0; % define the lower bound
xMax = 4; % define the uppper bound

stepSize = [0.5 0.1 0.01 0.001]; % define the step sizes

figure;   % define an empty figure
hold all;

lineTypes = {'-', '--', ':', '-.'};
lineColor = [0 0 0;
    1 0 0;
    0 1 0;
    0 0 1];         % define line colors for the different step sizes
textLegend = {''};  % create a cell array for the figure legend

for ii = 1:length(stepSize)

    n = (xMax - xMin) / stepSize(ii); % define the number of points to plot

    X = linspace(xMin,xMax,n+1); % define **EQUALLY** spaced
                                 % x-values between the bounds

    Y = zeros(size(X));          % pre-define an empty array of Y-values
    Y(1) = 1;                    % starting value of Y @ xMin (known)
%     Y(1) = 2;                    % starting value of Y @ xMin (known)

    %% Loop for the Euler method
    tic
    for jj = 1:n
        fValue = f(X(jj), Y(jj));  % f(x,y) using current X and Y values
        
        Y(jj + 1) = Y(jj) + stepSize(ii) * fValue; % succeeding Y value
    end
    disp(['For step size = ', num2str(stepSize(ii))]);
    toc
    disp('----');
    %%

    plot(X,Y,lineTypes{ii},'color',lineColor(ii,:),'lineWidth',2);
    hold all;
    tempText = ['h = ',num2str(stepSize(ii))];
    textLegend = [textLegend,tempText];

end

grid on; box on;
legend(textLegend(2:end),'Location','northwest');
xlabel('X');
ylabel('f(X,Y)');
hold  off

end

