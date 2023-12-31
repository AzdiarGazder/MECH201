function L08E11_higherOrderExample2_rungeKutta_heunMethod_routine2
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


% % Given the van der Pol equation:
% % (d^2y / dt^2) - (1 - y^2)*(dy / dt) + y = 0                 --- Eq (1)
% % 
% % Rename the variables as follows:
% % dy / dx = z                                                 --- Eq (2)
% % 
% % then for the first term in Eq (1)
% % (d^2y / dt^2) = differential of dy / dt
% % Since dy / dt = z (from above)
% % (d^2y / dt^2) = dz / dt                                     --- Eq (3)
% %
% % Substituting Eqs (2) and (3) into Eq (1)
% % (dz / dt) - (1 - y^2)*z + y = 0
% % or,
% % dz / dt = (1 - y^2)*z - y
% % which is a 1st order ODE 


%% 
clc; clear all; clear hidden; close all

f = @(x,y,z) [z;
     (1 - y.^2).*z - y]; % define the functions


tMin = 0;  % define the lower bound
tMax = 20; % define the uppper bound

stepSize = 0.5; % define the step size

figure;   % define an empty figure
hold all;

lineTypes = {'-o','-s'};   % define the line types
lineColor = [1 0 0;
    0 0 1];                % define line colors

n = (tMax - tMin) / stepSize; % define the number of points to plot

T = linspace(tMin,tMax,n+1)   % define **EQUALLY** spaced
                              % x-values between the bounds

Y = zeros(size(T));           % pre-define an empty array of Y-values
Z = zeros(size(T));           % pre-define an empty array of Z-values

Y(1,1) = 1                    % starting value of Y1 @ xMin (known)
Z(1,1) = 0.5                  % starting value of Z1 @ xMin (known)

%% Loop for the Heun method
for jj = 1:n
    disp('----')
    fValue_1 = f(T(jj), Y(:,jj), Z(:,jj)) % f1(x,y) using current X & Y values
    fValue_2 = f(T(jj+1), (Y(:,jj) + (fValue_1(1).* stepSize)), (Z(:,jj) + fValue_1(2).* stepSize)) % f2(x,y) using (X = succeeding X value) and Y1 & Y2 = current Y1 & Y2 values + (current f1(x,y) * stepSize)

    Y(:,jj + 1) = Y(:,jj) + (((fValue_1(1) + fValue_2(1)) / 2) * stepSize) % succeeding Y1 & Y2 values
    Z(:,jj + 1) = Z(:,jj) + (((fValue_1(2) + fValue_2(2)) / 2) * stepSize) % succeeding Y1 & Y2 values
end
%%


plot(T,Y,lineTypes{1},'color',lineColor(1,:),'lineWidth',2);
hold all;
plot(T,Z,lineTypes{2},'color',lineColor(2,:),'lineWidth',2);
hold all;

grid on; box on;
legend({'Y1','Y2'},'Location','northwest');
xlabel('X');
ylabel('f([X,Y1],[X,Y2])');
hold  off

end
