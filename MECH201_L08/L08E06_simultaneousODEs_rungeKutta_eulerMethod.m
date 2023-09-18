function L08E06_simultaneousODEs_rungeKutta_eulerMethod
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

f = @(x,y) [-0.5.*y(1) + y(2) + x.^2;
    4 - 0.3.*y(2) - 0.1.*y(1)]; % define the functions


xMin = 0; % define the lower bound
xMax = 2; % define the uppper bound

stepSize = 0.5; % define the step size

figure;   % define an empty figure
hold all;

lineTypes = {'-o','-s'};   % define the line types
lineColor = [1 0 0;
    0 0 1];                % define line colors

n = (xMax - xMin) / stepSize; % define the number of points to plot

X = linspace(xMin,xMax,n+1)       % define **EQUALLY** spaced
                                  % x-values between the bounds

Y = repmat(zeros(size(X)),[2,1]); % pre-define an empty array of Y-values
Y(1,1) = 4;                       % starting value of Y1 @ xMin (known)
Y(2,1) = 6                        % starting value of Y2 @ xMin (known)

%% Loop for the Euler method
for jj = 1:n
    disp('----')
    fValue = f(X(jj), [Y(1,jj) Y(2,jj)]) % f(x,y) using current X & Y1,Y2 values

    Y(:,jj + 1) = Y(:,jj) + (fValue * stepSize) % succeeding Y1,Y2 values
end
%%





plot(X,Y(1,:),lineTypes{1},'color',lineColor(1,:),'lineWidth',2);
hold all;
plot(X,Y(2,:),lineTypes{2},'color',lineColor(2,:),'lineWidth',2);
hold all;

grid on; box on;
legend({'Y1','Y2'},'Location','northwest');
xlabel('X');
ylabel('f([X,Y1],[X,Y2])');
hold  off

end
