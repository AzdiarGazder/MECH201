function L07E07_experimentalExample
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

% X = [0,    1.25, 3.75]
% Y = [13.5, 12,   10]

X = [0.5, 0.8, 1.5, 2.5, 4]
Y = [1.1, 2.4, 5.8, 7.6, 8.9]
disp('___________________________________________________________________')


%% Using MATLAB's default polyfit function
P = polyfit(X,Y,2); % fitting a second order polynomial
%%

syms x f(x)
disp('----')
disp('The equation of best fit is:')
pStr = ' ';
for ii = 1:length(P)
    if ii ~= length(P)
        if sign(P(ii+1)) == 1 || sign(P(ii+1)) == 0
            pStr = [pStr, num2str(P(ii)),'*x^',num2str(length(P)-ii), ' + '];
        else
            pStr = [pStr, num2str(P(ii)),'*x^',num2str(length(P)-ii), ' '];
        end
    else
        pStr = [pStr, num2str(P(end))];
    end
end
disp(pStr);
disp('----')
disp('The equation of best fit in MATLAB symbolic format is:')
f(x) = P(1).*x.^2 + P(2).*x + P(3)
disp('----')
disp('The differentiated equation of best fit in symbolic format is:')
df_dx = diff(f)
disp('----')
% disp(['...such that for x = 0 ; df(x) = ',num2str(double(df_dx(0)))])
% disp(['...such that for x = 2.0 ; df(x) = ',num2str(double(df_dx(2)))])
disp(['...such that for x = 1.5 ; df(x) = ',num2str(double(df_dx(1.5)))])
disp(['...such that for x = 3.0 ; df(x) = ',num2str(double(df_dx(3)))])

disp('___________________________________________________________________')


figure
plot(X,Y,'o-r','lineWidth',2); % data points
hold all;
xFine = min(X): 0.1: max(X); % defines finer steps between points for the equation of best fit
plot(xFine,f(xFine),'-k','lineWidth',2);
% legend('f(x)','Polyfit','Location','northeast');
legend('f(x)','Polyfit','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');
%%

end






