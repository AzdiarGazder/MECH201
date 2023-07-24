function L05E06_continuousFourierSeries1 % or L05E05_sinusoidFunction3

clc; clear all; clear hidden; close all

% % A0 = mean value = avg. height above the t-axis
% % C1 = amplitude = height of the oscillation
% % T = wavelength = time to complete one cycle in seconds
% % f = 1/T = frequency
% % omega0 = 2*pi()/T = 2*pi()*f = angular frequency
% % theta = phase angle = sinosoidal shift along the x-axis
% % t = time in seconds
% % 
% % If
% % f(t) = A0 + A1*cos(omega0 * t) + B1*sin(omega0 * t) +...
% %             A2*cos(omega0 * t) + B2*sin(omega0 * t) +...
% %             A3*cos(omega0 * t) + B3*sin(omega0 * t) +...
% %             ...
% %             Ak*cos(omega0 * t) + Bk*sin(omega0 * t)
% % such that:
% % A1 = C1*cos(theta)
% % B1 = -C1*sin(theta)
% %
% % The task of LSQR fitting is to find A0, A1....Ak and B1...Bk to minimise
% % Sr = sum((yi - f(t))^2)


%% Experimental data
A0 = 2;            % mean value = avg. height above the t-axis
C1 = 1;            % amplitude = height of the oscillation
T = 25;            % wavelength
f = 1/T;           % frequency
omega0 = 2*pi()/T; % angular frequency
theta = pi()/10;   % phase angle = sinosoidal shift along the x-axis

%% Method 2
% To see the effect of adding additional parameters while undertaking 
% integration or summation, change the end-value of the "jj" loop.

Ts = 0; % start point
Tf = 100;  % end point

% Define an arbitrary function F(t) with a period ranging from Ts to Tf
Ft = @(t)  A0 + C1.*cos((omega0 .* t) + theta);
% Define zero equations for summation
sumEq1 = @(t)0;
sumEq2 = @(t)0;

% Calculate the value of a0
n = length(Ts:Tf);
a0 = sum(Ft(Ts:Tf))/n;

% Calculate the values of AA1...AAjj & BB1...BBjj
for jj = 1:50
    % Summation (as per the previous Method 1)
    AA1jj = @(t) (2/n) * sum(Ft(Ts:Tf).*cos(jj.*omega0.*t)).*cos(omega0 .* t); % Here AA1jj = A(jj).*cos(omega0 .* t)
    BB1jj = @(t) (2/n) * sum(Ft(Ts:Tf).*sin(jj.*omega0.*t)).*sin(omega0 .* t); % Here BB1jj = B(jj).*sin(omega0 .* t)

    % Integration
    AA2jj = @(t) (2/n) * integral(@(t)Ft(t).*cos(jj.*omega0.*t),Ts,Tf) *cos(omega0 .* t);  % Here AA2jj = A(jj).*cos(omega0 .* t)
    BB2jj = @(t) (2/n) * integral(@(t)Ft(t).*sin(jj.*omega0.*t),Ts,Tf) *sin(omega0 .* t);  % Here BB2jj = B(jj).*sin(omega0 .* t)
    
    sumEq1 = @(t) sumEq1(t) + (AA1jj(t) + BB1jj(t)); % do the summations
    sumEq2 = @(t) sumEq2(t) + (AA2jj(t) + BB2jj(t));
end

% Combine a0 with the summation equations
finalEq1 = @(t) a0 + sumEq1(t);
finalEq2 = @(t) a0 + sumEq2(t);


figure
plot(Ts:Tf,Ft(Ts:Tf), 'o-r','lineWidth',2);
hold all;
plot(Ts:Tf,finalEq1(Ts:Tf), 'd-k','lineWidth',1);
fplot(finalEq2, [Ts,Tf], '*-b','lineWidth',1);
xlabel('time (seconds)')
ylabel('f(t)')
legend({'Experimental data', 'LSQR data (Summation)', 'LSQR data (Integration)'},...
    'Location','southeast')
hold off;


end