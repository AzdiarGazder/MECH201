function L08E04_rungeKutta_4thOrder_Example1
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

    %% Loop for the midpoint method
    tic
    for jj = 1:n
        fValue_1 = f(X(jj), Y(jj)); % f1(x,y) using current X & Y values
        fValue_2 = f((X(jj) + (stepSize(ii)/2)), (Y(jj) + (fValue_1 * (stepSize(ii)/2)))); % f2(x,y) using (X = current X value + stepSize/2) and (Y = current Y value + (f1(x,y) * stepSize/2))
        fValue_3 = f((X(jj) + (stepSize(ii)/2)), (Y(jj) + (fValue_2 * (stepSize(ii)/2)))); % f3(x,y) using (X = current X value + stepSize/2) and (Y = current Y value + (f2(x,y) * stepSize/2))
        fValue_4 = f((X(jj) + stepSize(ii)), (Y(jj) + (fValue_3 * stepSize(ii)))); % f3(x,y) using (X = current X value + stepSize) and (Y = current Y value + (f3(x,y) * stepSize))

        Y(jj + 1) = Y(jj) + ((fValue_1 + 2.*fValue_2 + 2.*fValue_3 + fValue_4) .* (stepSize(ii) / 6)); % succeeding Y value
    end
    disp(['For step size = ', num2str(stepSize(ii))]);
%     disp(['@ X = 0.5; Y = ',num2str(Y(X == 0.5))]);
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
ylabel('Y = f(X,Y)');
hold  off

end
