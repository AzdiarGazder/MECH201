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

C = [0.5, 0.8, 1.5, 2.5, 4]
K = [1.1, 2.4, 5.8, 7.6, 8.9]
disp('___________________________________________________________________')


%% Using MATLAB's default polyfit function
P = polyfit(C,K,2); % fitting a second order polynomial
%%

syms c f(c)
disp('----')
disp('The equation of best fit is:')
pStr = ' ';
for ii = 1:length(P)
    if ii ~= length(P)
        if sign(P(ii+1)) == 1 || sign(P(ii+1)) == 0
            pStr = [pStr, num2str(P(ii)),'*c^',num2str(length(P)-ii), ' + '];
        else
            pStr = [pStr, num2str(P(ii)),'*c^',num2str(length(P)-ii), ' '];
        end
    else
        pStr = [pStr, num2str(P(end))];
    end
end
disp(pStr);
disp('----')
disp('The equation of best fit in MATLAB symbolic format is:')
f(c) = P(1).*c.^2 + P(2).*c + P(3)
disp('----')
disp('The differentiated equation of best fit in symbolic format is:')
df_dc = diff(f)
disp('----')
disp(['...such that for c = 1.5 ; df(c) = ',num2str(double(df_dc(1.5)))])
disp(['...such that for c = 3.0 ; df(c) = ',num2str(double(df_dc(3)))])

disp('___________________________________________________________________')


figure
plot(C,K,'o-r','lineWidth',2); % data points
hold all;
xFine = min(C): 0.1: max(C); % defines finer steps between points for the equation of best fit
plot(xFine,f(xFine),'-k','lineWidth',2);
legend('f(x)','Polyfit','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');
%%

end






