function L05E05_sinusoidFunction2

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

t = [0:0.1:100];   % x-axis values = time (in seconds), or omega*t (in radians)
ft = A0 + C1.*cos((omega0 .* t) + theta); % y-axis values = Eq. y(t) 


%% Linear regression
n = length(t);
Sx = sum(t);
Sy = sum(ft);
Sycos = sum(ft.*cos(omega0.*t));
Sysin = sum(ft.*sin(omega0.*t));

Scos = sum(cos(omega0.*t));
Scos2 = sum(cos(omega0.*t).^2);

Ssin = sum(sin(omega0.*t));
Ssin2 = sum(sin(omega0.*t).^2);

Ssincos = sum(sin(omega0.*t).*cos(omega0.*t));


%% Method 1
disp('___________________________________________________________________')
disp('Using the approximations')
disp('------')
display('Least Squares Regression equation')
A0 = Sy/n;
display(['A0 = ', num2str(A0)]);

for jj = 1:1
    A(jj) = (2/n)*sum(ft.*cos(jj.*omega0.*t));
    B(jj) = (2/n)*sum(ft.*sin(jj.*omega0.*t));
    display(['A',num2str(jj),' = ',num2str(A(jj)),' ; ','B',num2str(jj),' = ',num2str(B(jj))]);
end
display(['equation: f(t) = ', num2str(A0),' + (', num2str(A(1)),' * cos(omega0 * t)) + (', num2str(B(1)),' * sin(omega0 * t)) ']);
disp('___________________________________________________________________')

% Substituting values into the best-fit equation
Yreg = A0 + A(1).*cos(omega0 .* t) + B(1).*sin(omega0 .* t);

figure
plot(t,ft,'o-r','linewidth',2)
hold all;
plot(t,Yreg,'*-b','linewidth',2)
xlabel('time (seconds)')
ylabel('f(t)')
legend({'Experimental data', 'LSQR data'},...
    'Location','southeast')
hold off;


end