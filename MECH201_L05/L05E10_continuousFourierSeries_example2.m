function L05E10_continuousFourierSeries_example2
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

Ts = -2*pi; % start point
Tf =  2*pi; % end point

% Define an arbitrary function F(t) with a period ranging from Ts to Tf
% In this example,  x = (omega0 * t)
F = @(x) (4/pi)*cos(x) - (4/(3*pi))*cos(3*x) + (4/(5*pi))*cos(5*x) - (4/(7*pi))*cos(7*x); %...+ (4/(9*pi))*cos(9*x) -...
% Define a zero equation for summation
sumEq = @(x)0;

% Calculate the value of a0
a0 = (1/Tf)*integral(F,Ts,Tf);

% Calculate the values of A1...Ak & B1...Bk
for k = 1:25
    A1k = @(x) (1/Tf) * integral(@(x)F(x).*cos(k*x),Ts,Tf) .* cos(k*x);
    B1k = @(x) (1/Tf) * integral(@(x)F(x).*sin(k*x),Ts,Tf) .* sin(k*x);
    sumEq = @(x) sumEq(x) + (A1k(x) + B1k(x)); % do the summation
end

% Combine a0 with the summation equation
finalEq = @(x) a0 + sumEq(x);


figure
fplot(F, [Ts,Tf], 'o-r','lineWidth',2);
hold all;
fplot(finalEq, [Ts,Tf], '*-b','lineWidth',1);
legend({'Experimental data', 'Fit (Integration)'},...
    'Location','southeast')
hold off;

end
