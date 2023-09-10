% function L07E05_richardsonExtrapolation
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/213823-forward-backward-and-central-differences
%
%%


% % Given the 4 equations:
% % D = D(h1) + E(h1) = D(h2) + E(h2)                           --- Eq (1)
% % E(h1) = -((b-a)/12) * h1^2 * f''(epsilon)                   --- Eq (2)
% % E(h2) = -((b-a)/12) * h2^2 * f''(epsilon)                   --- Eq (3)
% % E(h1) / E(h2) = h1^2 / h2^2                                 --- Eq (4)
% %
% % 
% % Show that:
% % E(h2) = (D(h1) - D(h2)) / (1 - (h1^2/h2^2)) ...The first proof
% %
% % and
% %
% % D = D(h2) + (D(h2) - D(h1)) /  ((h1/h2)^2 - 1) ...The second proof
% %
% % 
% % Step 1: Substitute E(h1) and E(h2) from Eqs. (2) and (3) into Eq. (1)
% % D(h1) + -((b-a)/12) * h1^2 * f''(epsilon) = D(h2) + -((b-a)/12) * h2^2 * f''(epsilon)
% %
% % Step 2: Move the D(h1) & D(h2) terms to the RHS and the other terms to the LHS and then flip
% % D(h2) - D(h1) = ((b-a)/12) * h2^2 * f''(epsilon) -((b-a)/12) * h1^2 * f''(epsilon)
% %
% % Step 3: Factor out ((b-a)/12) * f''(epsilon) from the RHS
% % D(h2) - D(h1) = ((b-a)/12) * f''(epsilon) * (h2^2 - h1^2)
% %
% % Step 4: Relocating the terms such that
% % ((b-a)/12) * f''(epsilon) = (D(h2) - D(h1)) / (h2^2 - h1^2)
% %
% % Step 5: Now, substitute Step 4 into Eq (3)
% % E(h2) = -((D(h2) - D(h1)) / (h2^2 - h1^2)) * h2^2
% %
% % Step 6: Relocating the minus sign into the bracket in the numerator
% % E(h2) = ((D(h1) - D(h2)) / (h2^2 - h1^2)) * h2^2
% %
% % Step 7: Putting all numerator terms together
% % E(h2) = ((D(h1) - D(h2)) * h2^2) /  (h2^2 - h1^2)
% %
% % Step 8: The denominator can also be expressed as
% % E(h2) = ((D(h1) - D(h2)) * h2^2) /  (h2^2 * (1 - (h1^2 /h2^2)))
% %
% % Step 9: Cancelling out the h2^2 term in the numerator and denominator results in
% % E(h2) = (D(h1) - D(h2)) /  (1 - (h1^2 /h2^2)) ...The first proof
% %
% % Step 10: Substitute Step 9 into the 3rd part of Eq. (1)
% % D = D(h2) + (D(h1) - D(h2)) /  (1 - (h1^2 /h2^2))
% %
% % Step 11: Multiplying numerator and denominator of the second term with -1 results in
% % D = D(h2) + (D(h2) - D(h1)) /  ((h1/h2)^2 - 1) ...The second proof


%% 
clc; clear all; clear hidden; close all

disp('___________________________________________________________________')
syms x f
f(x) = -0.1.*x.^4 -0.15.*x.^3 -0.5.*x.^2 -0.25.*x +1.2

% Analytical solution - symbolic
df_dx = diff(f,1)
disp('___________________________________________________________________')


% step sizes
stepSize = [0.5, 0.25, 0.125 0.0625];

lineTypes = {'-o','-s','-d','-*'};           % define the line types
lineColor = [1 0 0; 0 1 0; 0 0 1; 0.5 0.5 0.5];    % define line colors

for ii = 1:length(stepSize)

    % x-values for which derivatives require calculation
    x = linspace(0,1,(1/stepSize(ii))+1);

    % Analytical solution - numerical
    Df = double(df_dx(x));

    %% Taylor series expansion (1st order approximation)
    F = f(x); % to enable the replacing of different x values into the equation

    % % Centred divided difference
    x_centred = x(2:end-1);
    dF_centred = double((F(3:end) - F(1:end-2)) / (2 * stepSize(ii)));
    err_centred = 100.*abs((Df(2:end-1) - dF_centred) ./ Df(2:end-1));
    %%

    % Display the results
    figure
    plot(x,Df,'--','color',lineColor(ii,:),'lineWidth',2);
    hold all;
    plot(x_centred,dF_centred,lineTypes{ii},'color',lineColor(ii,:),'lineWidth',2)
    legend({'Analytical','Centred'},'location','northeast')
    hold off

    % Build a structure variable
    T(ii).x = x';
    T(ii).df_dx = Df';

    T(ii).df_C = [NaN,dF_centred,NaN]';
    T(ii).epsilonT_C = [NaN,err_centred,NaN]';
end

% Applying Richardson's extrapolation to the structure T data
D_h1 = T(1).df_C(2);
D_h2 = T(2).df_C(3);
D_analytical = T(1).df_dx(2);  % % or T(2).df_dx(3)

D_re = (4/3 * D_h2) - (1/3 * D_h1);

err_h1 = 100*abs((D_analytical - D_h1) / D_analytical);
err_h2 = 100*abs((D_analytical - D_h2) / D_analytical);
err_RE = 100*abs((D_analytical - D_re) / D_analytical);

disp('___________________________________________________________________')
disp('Differential calculation via the centred divided difference method:')
disp('----')
disp(['For step size = ',num2str(stepSize(1))])
disp(['x                                     = ', num2str(T(1).x(2))])
disp(['df / dx via analytical method         = ', num2str(D_analytical)]);
disp(['df / dx via CDD method                = ', num2str(D_h1)]);
disp(['Error between analytical and CDD (%)  = ',num2str(err_h1)]);
disp('----')
disp(['For step size = ',num2str(stepSize(2))])
disp(['x                                     = ', num2str(T(2).x(3))]);
disp(['df / dx via analytical method         = ', num2str(D_analytical)]);
disp(['df / dx via CDD method                = ', num2str(D_h2)]);
disp(['Error between analytical and CDD (%)  = ',num2str(err_h2)]);
disp('----')
disp(['df / dx via Richardson''s extrapolation                       = ',num2str(D_re)])
disp(['Error between analytical and Richardson''s extrapolation (%)  = ',num2str(err_RE)]);
disp('___________________________________________________________________')

% end