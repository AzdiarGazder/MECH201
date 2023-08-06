function L03E09_gaussSeidel_convergeRelax
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

%% Given 3 linear algebraic equations

% %   3*x1  -  0.1*x2  - 0.2*x3 =   7.85    --- Eq.(1)
% % 0.1*x1  +    7*x2  - 0.3*x3 = -19.30    --- Eq.(2)
% % 0.3*x1  -  0.2*x2  +  10*x3 = -71.40    --- Eq.(3)
% %
% %
% % This can be re-written in matrix form as:
% % |  3   -0.1   -0.2|   |x1|    |  7.85|    --- Eq.(1)
% % |0.1      7   -0.3| * |x2| =  |-19.30|    --- Eq.(2)
% % |0.3   -0.2     10|   |x3|    |-71.40|    --- Eq.(3)
% %


%% ---
disp('___________________________________________________________________')
A = [3   -0.1   -0.2;...
    0.1     7   -0.3;...
    0.3  -0.2     10]

B = [7.85;...
    -19.3;...
    -71.4]


%% ---
disp('___________________________________________________________________')
disp('Using a custom Gauss-Seidel script with relaxation factor (lambda) varying from 0.1 to 100 in steps of 0.1')
disp('------')

maxIter = 1000;     % maximum number of iterations
tol = 1E-4;         % tolerance in lecture notes
solNFound = false;  % flag for solution


step = 1;
for lambda = 0.1:0.1:100       % relaxation factor
    lgthA = length(A);
    X = zeros(lgthA,1);

    % Main loop
    tic
    for iter = 1:maxIter
        oldX = X;  % save current values to calculate error later
        for ii = 1:lgthA
            X(ii) = (B(ii) - sum(A(ii,:)*X(:)) + A(ii,ii)*X(ii)) / A(ii,ii);
            X(ii) = (lambda*X(ii)) + ((1-lambda)*oldX(ii));
        end
        err = abs((X - oldX)./X);

        if all(err <= tol) % solution found
            solNFound = true;
            break; % exit the loop
        end
    end

    endTime = toc;
    sp(step,1) = iter/endTime;
    step = step + 1;
end

plot(0.1:0.1:100,sp,'.-r')
xlabel('Lambda value')
ylabel('Iterations per second (iter/s)')

end