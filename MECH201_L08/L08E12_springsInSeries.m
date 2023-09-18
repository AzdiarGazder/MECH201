function L08E12_springsInSeries
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/457264-2-degrees-of-freedom-mass-spring-system
% https://au.mathworks.com/matlabcentral/fileexchange/42508-two-or-three-masses-connected-by-springs
%
%%


% % The system is composed of two masses joined by two springs
% % 
% % If
% % dx1 / dt = v1 ...velocity of spring 1                       --- Eq (1)
% % dx2 / dt = v2 ...velocity of spring 2                       --- Eq (2)
% %
% % And
% % d^2x1 / dt^2 = dv1/dt = a1  ...acceleration of spring 1     --- Eq (3)
% % d^2x2 / dt^2 = dv2/dt = a2  ...acceleration of spring 1     --- Eq (4)
% %
% % Given that Force = mass * acceleration
% % = m1 * (d^2x1 / dt^2) = -k1 * x1 + k2*(x2 - x1)
% % = d^2x1 / dt^2 = (-k1 * x1 + k2*(x2 - x1)) / m1 ...for spring 1 --- Eq (5)
% %
% % = m2 * (d^2x2 / dt^2) = -k1*(x2 - x1) - k2 * x2
% % = d^2x2 / dt^2 = (-k1*(x2 - x1) - k2 * x2) / m2 ...for spring 2 --- Eq (6)
% %
% % Then by substituting Eq (5) into Eq (3) and Eq (6) into Eq (4))
% % dv1/dt = (-k1 * x1 + k2*(x2 - x1)) / m1 ...for spring 1     --- Eq (7)
% % dv2/dt = (-k1*(x2 - x1) - k2 * x2) / m2 ...for spring 2     --- Eq (8)


%%
clc; clear all; clear hidden; close all

% Properties of the system
m1 = 150; % mass 1 [kg]
m2 = 200; % mass 2 [kg]
k1 = 100; % spring 1 stiffness [N/m]
k2 = 150; % spring 2 stiffness [N/m]
g = 9.81; % accceleration due to gravity [m/s^2]


% Solving the system of differential equations
tMin = 0; 
tMax = 2*pi; 
tRange = [tMin tMax];

m1 = m1 * g; % converting from kg to N
m2 = m2 * g; % converting from kg to N

odefun = @(t,y) solve_2ndOrder(t, y, m1, m2, k1, k2);

A = [[-(k1+k2), k2]./m1;...
    [k2, -(k2)]./m2]
[eigenVectors, eigenValues] = eig(A);
[~,idx] = sort(diag(eigenValues));
eigenVectors = eigenVectors(:,idx) % sort from higher to lower frequency

x1 = eigenVectors(1,1);
x2 = eigenVectors(2,1);
v1 = 0;
v2 = 0;
[tsol,ysol] = ode45(odefun, tRange, [x1,v1,x2,v2])



% Graphing the system response
subplot(2,1,1)
plot(tsol,ysol(:,1),'r','lineWidth',2); 
hold all;
plot(tsol,ysol(:,3),'b','lineWidth',2); 
% xlim([0 max(tsol)]);
% ylim([0, max(max([ysol(:,1);ysol(:,3)]))]);
hold off;
xlabel('time [s]');
ylabel('shift [m]');
legend('x1','x2');


subplot(2,1,2)
plot(tsol,ysol(:,2),'--r','lineWidth',2); 
hold all;
plot(tsol,ysol(:,4),'--b','lineWidth',2); 
% xlim([0 max(tsol)]);
% ylim([0, max(max([ysol(:,2);ysol(:,4)]))]);
hold off;
xlabel('time [s]');
ylabel('velocity [m/s]');
legend('xdot1','xdot2');


% % %% output accuracy check
% % return
% % figure
% % plot(tsol,ysol(:,1),'*'); 
% % hold all; grid on;
% % % fit the curve
% % p = polyfit(tsol,ysol(:,1),4);
% % % % plot the fitted results
% % kpoly = polyval(p,tsol);
% % plot(tsol,kpoly,'r'); 
% % hold off;
% % 
% % syms f(c)
% % f(c) = p(1).*c.^4 + p(2).*c.^3 + p(3).*c.^2 + p(4).*c + p(5);
% % Df = diff(f,c);
% % figure
% % plot(tsol,Df(tsol),'.-g')
% % hold all;
% % plot(tsol,ysol(:,2),'.-b')
% % hold off;
% % %%

end


function dy = solve_2ndOrder(~, y, m1, m2, k1, k2)
dy = zeros(4,1);
dy(1) = y(2);
dy(2) = (-(k1+k2)*y(1) + k2*y(3))/m1;
dy(3) = y(4);
dy(4) = (k2*y(1) - (k2)*y(3))/m2;
end