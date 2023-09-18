function L08E05_rungeKutta_matlab_RK45RK23
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%% 
clc; clear all; clear hidden; close all

f = @(x,y) 4.*exp(0.8.*x) - 0.5.*y; % define a function

xMin = 0; % define the lower bound
xMax = 4; % define the uppper bound

stepSize = [0.5 0.1 0.01 0.001]; % define the step sizes

figure(1);   % define an empty figure
hold all;

figure(2);   % define an empty figure
hold all;

lineTypes = {'-', '.', ':', '-.'};
lineColor = [0 0 0;
    1 0 0;
    0 1 0;
    0 0 1];         % define line colors for the different step sizes
textLegend = {''};  % create a cell array for the figure legend


Y0 = 2; % starting value of Y @ xMin (known)
for ii = 1:length(stepSize)

    n = (xMax - xMin) / stepSize(ii); % define the number of points to plot

    X = linspace(xMin,xMax,n+1); % define **EQUALLY** spaced
    % x-values between the bounds

    %% The ode45 method
    disp(['For step size = ', num2str(stepSize(ii))]);
    tic
    [X_ode45,Y_ode45] = ode45(f,X,Y0);
    toc
    %% The ode23 method
    tic
    [X_ode23,Y_ode23] = ode23(f,X,Y0);
    toc
    disp('----');
    %%

    figure(1)
    plot(X_ode45,Y_ode45,lineTypes{ii},'color',lineColor(ii,:),'lineWidth',2);
    hold all;

    figure(2)
    plot(X_ode23,Y_ode23,lineTypes{ii},'color',lineColor(ii,:),'lineWidth',2);
    hold all;

    tempText = ['h = ',num2str(stepSize(ii))];
    textLegend = [textLegend,tempText];

end

figure(1)
grid on; box on;
legend(textLegend(2:end),'Location','northwest');
xlabel('X');
ylabel('Y = f(X,Y)');
title('Using ode45');
hold  off

figure(2)
grid on; box on;
legend(textLegend(2:end),'Location','northwest');
xlabel('X');
ylabel('Y = f(X,Y)');
title('Using ode23');
hold  off

end
