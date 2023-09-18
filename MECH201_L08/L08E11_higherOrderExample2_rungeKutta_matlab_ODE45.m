function L08E11_higherOrderExample2_rungeKutta_matlab_ODE45
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


% % Given the van der Pool equation:
% % (d^2y / dt^2) - (1 - y^2)*(dy / dt) + y = 0                 --- Eq (1)
% % 
% % Rename the variables as follows:
% % y = y(1)                                                    --- Eq (2)
% % 
% % then
% % dy / dt = dy(1) / dt = y(2)                                 --- Eq (3)
% % 
% % then for the first term in Eq (1)
% % (d^2y / dt^2) = differential of dy / dt
% % Since dy / dt = y(2) (from above)
% % (d^2y / dt^2) = dy(2)/dt                                    --- Eq (4)
% %
% % Substituting Eqs (2) to (4) into Eq (1)
% % (dy(2) / dt) - (1 - y(1)^2)*y(2) + y(1) = 0
% % or,
% % (dy(2) / dx) = (1 - y(1)^2)*y(2) - y(1)
% % which is a 1st order ODE 


%%
clc; clear all; clear hidden; close all

f = @(x,y) [y(2);
     (1 - y(1).^2).*y(2) - y(1)]; % define the functions


tMin = 0;  % define the lower bound
tMax = 20; % define the uppper bound

stepSize = 0.5; % define the step size

figure;   % define an empty figure
hold all;

lineTypes = {'-o','-s'};   % define the line types
lineColor = [1 0 0;
    0 0 1];                % define line colors

n = (tMax - tMin) / stepSize; % define the number of points to plot

T = linspace(tMin,tMax,n+1); % define **EQUALLY** spaced
                             % x-values between the bounds

Y(1,1) = 1;                  % starting value of Y1 @ xMin (known)
Y(2,1) = 0.5;                % starting value of Y2 @ xMin (known)

%% The ode45 method
[X_ode45,Y_ode45] = ode45(f,T,[Y(1,1) Y(2,1)])
%%


plot(X_ode45,Y_ode45(:,1),lineTypes{1},'color',lineColor(1,:),'lineWidth',2);
hold all;
plot(X_ode45,Y_ode45(:,2),lineTypes{2},'color',lineColor(2,:),'lineWidth',2);
hold all;

grid on; box on;
legend({'Y1','Y2'},'Location','northwest');
xlabel('X');
ylabel('f([X,Y1],[X,Y2])');
hold  off

end
