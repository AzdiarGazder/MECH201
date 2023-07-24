function L01E08_linearAlgEqN

clc; clear all; clear hidden; close all

tic
%% Given 3 linear algebraic equations

% %   3*x1  - 0.1*x2  - 0.2*x3 =   7.85    --- Eq.(1)
% % 0.1*x1  +   7*x2  - 0.3*x3 = -19.3     --- Eq.(2)
% % 0.3*x1  - 0.2*x2  -  10*x3 =  71.4     --- Eq.(3)
% %
% %
% % This can be re-written in matrix form as:
% % |  3   -0.1   -0.2|   |x1|    | 7.85|    --- Eq.(1)
% % |0.1      7   -0.3| * |x2| =  |-19.3|    --- Eq.(2)
% % |0.3   -0.2    -10|   |x3|    | 71.4|    --- Eq.(3)
% %
% % This is simplified as [A]*[X] = [B]
% %
% % such that [X] = [A]^-1 * [B]
% % or        [X] = inv[A] * [B]

%% ---
disp('------')
A = [ 3  -0.1  -0.2;...
    0.1     7  -0.3;...
    0.3  -0.2    10]

B = [7.85;...
    -19.3;...
    71.4]


%% ---
disp('------')
disp('As per the matrix division rule')
X = A\B

% % NOTE:
% % A\B is equivalent to solving the linear algebra problem A*X = B.
% % A/B is equivalent to solving the linear algebra problem X*B = A.

% %% ---
% disp('------')
% disp('As per the matrix inversion and multiplication rule')
% X = inv(A)*B
%
%
% %% ---
% disp('------')
% disp('As per Cramer''s rule')
% for ii = 1:size(A,2)
%     tempA = A;
%     tempA(:,ii) = B;
%     X(ii,1) = det(tempA) / det(A);
% end
% X

toc

end
