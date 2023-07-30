function L02E08_bairstow_example2
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
% 
%%


%%
clc; clear all; clear hidden; close all

% % GENERAL METHOD:
% % Given a polynomial equation, re-write it to the following format:
% % P(x) = (x^2 - r*x + s) * Q(x) + R(x)
% % Bairstow's method then uses the division property to find the values of
% % r and s that makes R(x) = 0 and conseuqently, (x^2 - r*x + s) is a 
% % root of the equation. 


% Define a polynomial equation
syms x;
P = x^3 - 4*x^2 + 5.25*x - 2.5;
% % where the polynomial is represented by coefficients "a" such that
% % a(n+1)*x^n + a(n)*x^n-1 + a(n-1)*x^n-2 + ... + a(1)

% % Find the order of the polynomial equation
% order = polyOrder(P,x);

% Find the array of coefficients of the polynomial (including the
% constant) in the order of increasing powers of x
a = double(coeffs(P));

r = -1; % initial guess
s = -1; % initial guess


maxIter = 1000;    % maximum number of iterations
tol = 1E-12;       % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

b = zeros(size(a));
c = zeros(size(a));

% Main loop
tic
for iter = 1:maxIter

    for ii = length(b):-1:1
        if ii == length(b)
            b(ii) = a(ii);
            c(ii) = b(ii);
        elseif ii == length(b)-1
            b(ii) = a(ii) + r*b(ii+1);
            c(ii) = b(ii) + r*c(ii+1);
        elseif ii <= length(b)-2 && ii >= 1
            b(ii) = a(ii) + r*b(ii+1) + s*b(ii+2);
            c(ii) = b(ii) + r*c(ii+1) + s*c(ii+2);
        end
    end

    % % Method 1: Solving quadratic equations using matrices
    %     syms deltaR deltaS
    %     eq1 = c(3)*deltaR + c(4)*deltaS == -b(2);
    %     eq2 = c(2)*deltaR + c(3)*deltaS == -b(1);
    %     [A,B] = equationsToMatrix([eq1, eq2], [deltaR,deltaS]);
    %     X = double(linsolve(A,B)); % solution for deltaR and deltaS
    %     dr = X(1); ds = X(2);

    % % Method 2: Solving quadratic equations using a Jacobian matrix
    J = [c(3),c(4);...
        c(2), c(3)]; % Jacobian
    B = [-b(2);...
        -b(1)];
    X = mldivide(J,B); % solution for deltaR and deltaS
    dr = X(1); ds = X(2);

    
    errAR = abs(((r + dr)-r)/(r + dr));
    errAS = abs(((s + ds)-s)/(s + ds));


    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.r = r;
    tempTable.s = s;
    tempTable.deltaR = dr;
    tempTable.deltaS = ds;
    tempTable.errAR = errAR;
    tempTable.errAS = errAS;
    T = [T;tempTable]; % append to table
    %---

    if errAR <= tol && errAS <= tol % solution was found
        solNFound = true;
        break;
    end

    % Apply the correction to r and s
    r = r + dr;
    s = s + ds;
end

% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','r','s','deltaR','deltaS','errAR','errAS'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Bairstow''s method converged in ',num2str(iter), ' iteration(s).'])
    disp(['r = ',num2str(r)]);
    disp(['s = ',num2str(s)]);

    fprintf("Quadratic factor = x^2 -(%g)x - (%g)\n", r, s);

    fprintf("Q(x)             = (%g)x^%d", b(length(b)), length(b)-2);
    for ii = length(b)-3 : -1 : 1
        fprintf("  + (%g)x^%d", b(ii+2), ii);
    end
    fprintf("  +  (%g)\n", b(3));

    fprintf("R(x) = remainder = %g (x-(%g)) + (%g)\n", b(2), r, b(1));

    % Evaluate the polynomial at x = Root 1 and Root 2
    s1 = (r + sqrt(r^2 + 4*s))/2;
    if (r^2 + 4*s) < 0
        fprintf("Roots            = %.13g ± (%.13g)i\n", real(s1), abs(imag(s1)));
    else
        s2 = (r - sqrt(r^2 + 4*s))/2;
        fprintf("Roots            = %.13g, %.13g\n", s1, s2);
    end
    disp('-------')


else % if no solution found
    error('No solution. Bairstow''s method did not converge in %d iteration(s).', maxIter);
end
toc

end


% function order = polyOrder(eqP,x)
% order = 0;
% temp = 1;
% while(temp~=0)
%
%     eqP = diff(eqP,x);
%     if eqP == 0
%         temp = 0;
%     else
%         order = order + 1;
%     end
% end
% end


