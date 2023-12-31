function L05E07_sinusoidFunction_example1
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


% % A0      = mean value = avg. height above the t-axis
% % C1      = amplitude = height of the oscillation
% % T       = wavelength = time to complete one cycle in seconds
% % f       = 1/T = frequency
% % omega0  = 2*pi()/T = 2*pi()*f = angular frequency
% % theta   = phase angle = sinosoidal shift along the x-axis
% % t       = time in seconds
% % 
% % f(t) = A0 + C1*cos((omega0 * t) + theta);
% %
% % If a = (omega0 * t) and b = theta
% % then cos(a + b) = cos(a)*cos(b) - sin(a)*sin(b)
% %
% % and f(t) = A0 + C1*(cos(a)*cos(b) - sin(a)*sin(b))
% %
% % f(t) = A0 + (C1*cos(omega0 * t)*cos(theta)) - (C1*sin(omega0 * t)*sin(theta))
% % f(t) = A0 + (C1*cos(omega0 * t)*cos(theta)) - (C1*sin(omega0 * t)*sin(theta))
% % f(t) = A0 + (C1*cos(theta)*cos(omega0 * t)) - (C1*sin(theta)*sin(omega0 * t))
% % f(t) = A0 + A1*cos(omega0 * t) + B1*sin(omega0 * t)
% %
% % such that:
% % A1 =  C1*cos(theta)
% % B1 = -C1*sin(theta)
% %
% % The task of LSqR fitting is to find A0, A1 and B1 to minimise
% % Sr = sum((yi - (A0 + A1*cos(omega0 * t) + B1*sin(omega0 * t)))^2)


%%
clc; clear all; clear hidden; close all

% Experimental data
A0 = 2;            % mean value = avg. height above the t-axis
C1 = 1;            % amplitude = height of the oscillation
t = [0:0.1:100];   % time = x-axis values
T = 25;            % wavelength
f = 1/T;           % frequency
omega0 = 2*pi()/T; % angular frequency
theta = pi()/10;   % phase angle = sinosoid shift along the t-axis
ft = A0 + C1.*cos((omega0 .* t) + theta); % = y-axis values


n = length(t);
Sft = sum(ft);
Sftcos = sum(ft.*cos(omega0.*t));
Sftsin = sum(ft.*sin(omega0.*t));

Scos = sum(cos(omega0.*t));
ScosSq = sum(cos(omega0.*t).^2);

Ssin = sum(sin(omega0.*t));
SsinSq = sum(sin(omega0.*t).^2);

Ssincos = sum(sin(omega0.*t).*cos(omega0.*t));

%% ---
tic
disp('___________________________________________________________________')
disp('Using default MATLAB Gauss eliminaton functions')
A = [n    Scos    Ssin;...
    Scos  ScosSq  Ssincos;...
    Ssin  Ssincos SsinSq]

B = [Sft;...
    Sftcos;...
    Sftsin]

% Factorise the full or sparse matrix A into:
% L = a permuted lower triangular matrix, and
% U = an upper triangular matrix from Gaussian elimination with partial
%     pivoting
% such that A = L*U
[L, U] = lu(A);
% % If solving for the linear algebra problem A*XX = B, then
XX = U \ (L \ B);
% % which is equivalent to XX = A\B or XX = inv(A)*B
AA0 = XX(1); AA1 = XX(2); BB1 = XX(3);
toc
disp('___________________________________________________________________')



disp('------')
display('Least Squares Regression equation')
display(['A0 = ', num2str(AA0)]);
display(['A1 = ', num2str(AA1)]);
display(['B1 = ', num2str(BB1)]);
display(['equation: f(t) = ', num2str(AA0),' + (', num2str(AA1),' * cos(omega0 * t)) + (', num2str(BB1),' * sin(omega0 * t)) ']);

% Substituting values into the best-fit equation
Yreg = AA0 + AA1.*cos(omega0 .* t) + BB1.*sin(omega0 .* t);

figure
plot(t,ft,'o-r','linewidth',2)
hold all;
plot(t,Yreg,'*-b','linewidth',2)
xlabel('time (seconds)')
ylabel('f(t)')
legend({'Experimental data', 'LSqR fit'},...
    'Location','southeast')
hold off;


end