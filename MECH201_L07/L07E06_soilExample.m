function L07E06_soilExample
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% % Script modified from:
% METHOD 1
% https://au.mathworks.com/matlabcentral/fileexchange/13151-lagrange-interpolator-polynomial
% METHOD 2
% https://www.mathworks.com/matlabcentral/answers/305169-what-is-the-code-for-lagrange-interpolating-polynomial-for-a-set-of-given-data
%
%%


%% 
clc; clear all; clear hidden; close all

X = [0,    1.25, 3.75]
Y = [13.5, 12,   10]
disp('___________________________________________________________________')


%% General form of Lagrange's linear interpolating polynomials
N = length(X);

% % METHOD 1
L = zeros(N,N);

% Calculate the polynomial weights for each order
% % METHOD 1
for ii = 1:N
    % the polynomial whose roots are all the values of X except this one
    pp = poly(X((1:N) ~= ii));
    % scale so its value is exactly 1 at this X point (and zero
    % at others)
    L(ii,:) = pp ./ polyval(pp, X(ii));
end
% Each row gives the polynomial that is 1 at the corresponding X
% point and zero everywhere else, so weighting each row by the
% desired row and summing (in this case the polycoeffs) gives
% the final polynomial
P = Y*L;


% % % METHOD 2
% P = 0;
% for ii = 1:N
%     L = 1;
%     for jj = 1:N
%         if jj~=ii
%             c = poly(X(jj)) / (X(ii) - X(jj));
%             L = conv(L,c);
%         end
%     end
%     P = P + L*Y(ii);
%     L = [];
% end
% disp(P);


% Solve for x such that dy/dx is zero (i.e. roots of the derivative polynomial)
% the derivative of polynomial P scales each power by its power, 
% i.e. - downshifts
R = roots(((N-1):-1:1) .* P(1:(N-1)));

% calculate the actual values at the points of zero derivative
S = polyval(P,R);
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
disp('or')
pretty(f)
disp('----')
disp('The differentiated equation of best fit in symbolic format is:')
df_dx = diff(f)
disp('or')
pretty(df_dx)
disp('----')
disp(['...such that for x = 0 ; df(x) = ',num2str(double(df_dx(0))),' °C / cm'])
disp(['...such that for x = 2 ; df(x) = ',num2str(double(df_dx(2))),' °C / cm'])

disp('___________________________________________________________________')



figure
plot(X,Y,'o-r','lineWidth',2); % data points
hold all;
xLagrange = min(X): 0.1: max(X); % defines finer steps between points for the equation of best fit
plot(xLagrange,f(xLagrange),'-k','lineWidth',2);
legend('f(x)','Lagrangian interpolation','Location','northeast');
xlabel('Soil depth (X in cm)');
ylabel('Temperature (Y = f''(X) in °C)');
%%

end
