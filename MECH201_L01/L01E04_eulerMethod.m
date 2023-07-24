function L1E4_eulerMethod

clc; clear all; clear hidden; close all

g = 9.81;    % in m/(s^2)      = acceleration due to gravity
c = 12.5;    % in kg/m         = drag coefficient
m = 68.1;    % in kg = m1 + m2 = mass of parachutist + parachute
delta_t = 2; % in s            = time interval

% at the start
t = 0; t_old = 0;
v_old = 0;

maxIter = 35;   % maximum number of iterations

T = table();    % create an empty table
tempTable = table();

% Main loop
tic
for iter = 1:maxIter
    % % Since v = v + dv
    % %
    % % And dv/dt = g - ((c/m)*v)
    % % Or  dv = [g - ((c/m)*v)] * dt
    % %
    % % Therefore, v = v + dv = v + [g - ((c/m)*v)] * dt
    v = v_old + ((g - (c/m)*v_old) * (t - t_old));

    % build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.t = t;
    tempTable.v_old = v_old;
    tempTable.v_new = v;
    T = [T;tempTable]; % append to table
    %---

    v_old = v;
    t_old = t;
    t = t + delta_t;

end

T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
T.Properties.VariableNames =  {'iter','t','v_old','v'}; % rename the columns to remove "Fun_" in the header
disp(T); % show the table in the command window

time = arrayfun(@(x) str2double(x), string(T.t));  % convert table columns to double array
velocity = arrayfun(@(x) str2double(x), string(T.v));



%% ---
% % From https://au.mathworks.com/help/symbolic/modeling-the-velocity-of-a-paratrooper.html
% % And L1E3_mathModel.m
% % Define the differential equation describing the equation of motion
syms v(t) g c m;
eq = diff(v(t),t)  == g - ((c/m)*v);

% % Assuming that the parachute opens immediately at t = 0 so that the
% % equation "eq" is valid for all values of t >= 0.
% % Solve the differential equation analytically using dsolve with the
% % initial condition v(0) == 0.
% % This solution represents the instantaneous velocity of the paratrooper
% as a function of time.
cond = v(0) == 0;
velSolN(t) = simplify(dsolve(eq,cond));

% Numerically calculate the instantaneous velocity
for ii = 1:length(time)
    iV = subs(velSolN,[g,m,c,t],[9.81, 68.1, 12.5, time(ii)]);
    instVelocity(ii) = double(vpa(iV));
end

% % The paratrooper approaches a constant velocity when the gravitational
% force (Fd) is balanced by the drag force (Fu). This is called the
% terminal velocity and it occurs when the drag force from the parachute
% cancels out the gravitational force (i.e., there is no further
% acceleration).
% Find the terminal velocity by taking the limit of t -> inf.
tV = subs(velSolN,[g,m,c,t],[9.81, 68.1, 12.5, inf]);
termVelocity = double(vpa(tV));
%% ---
toc


% Plot the graph
plot(time,velocity,'-k','LineWidth',2,'DisplayName',['Instant velocity (Numerical SolN)']);
hold all;
plot(time,instVelocity,'-.b','LineWidth',2,'DisplayName',['Instant velocity (Analytical SolN)']);
hold all;
plot(0:delta_t:max(time),repmat(termVelocity,[length(time),1]),'--r','LineWidth',2,'DisplayName',['Terminal velocity']);
xlabel('time (s)')
ylabel('velocity (m/s)')
legend('location','southeast')
hold off;

end