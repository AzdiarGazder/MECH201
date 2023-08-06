function L03E03_matrixLinearMultipleVariables
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%


%%
clc; clear all; clear hidden; close all

tic
%% Given 3 linear algebraic equations

% % 0.3*x1  + 0.52*x2  +   1*x3 = - 0.01    --- Eq.(1)
% % 0.5*x1  +    1*x2  + 1.9*x3 =   0.67    --- Eq.(2)
% % 0.1*x1  +  0.3*x2  + 0.5*x3 = - 0.44    --- Eq.(3)
% %
% %
% % This can be re-written in matrix form as:
% % |0.3   0.52      1|   |x1|    |-0.01|    --- Eq.(1)
% % |0.5      1    1.9| * |x2| =  | 0.67|    --- Eq.(2)
% % |0.1    0.3    0.5|   |x3|    |-0.44|    --- Eq.(3)
% %
% % This is simplified as [A]*[X] = [B]
% %
% % such that [X] = [A]^-1 * [B]
% % or        [X] = inv[A] * [B]


%% ---
disp('___________________________________________________________________')
A = [0.3   0.52      1;...
    0.5      1    1.9;...
    0.1    0.3    0.5]

B = [-0.01;...
    0.67;...
    -0.44]


%% ---
disp('___________________________________________________________________')
disp('As per the matrix division rule')
X = A\B

% % NOTE:
% % A\B is equivalent to solving the linear algebra problem A*X = B.
% % A/B is equivalent to solving the linear algebra problem X*B = A.

%% ---
disp('___________________________________________________________________')
disp('As per the matrix inversion and multiplication rule')
X = inv(A)*B


%% ---
disp('___________________________________________________________________')
disp('As per Cramer''s rule')
A
disp(['det(A) = ',num2str(det(A))])
B
X = zeros(length(A),1)
disp('------')
for ii = 1:size(A,2)
    tempA = A
    disp(['Substuting the values of B in AA(:,',num2str(ii),')']);
    tempA(:,ii) = B
    disp(['det(tempA) = ',num2str(det(tempA))])
    disp(['X(',num2str(ii), ') = det(tempA) / det(A) = ',num2str(det(tempA)),' / ',num2str(det(A)),' = ',num2str(det(tempA) / det(A))])
    X(ii,1) = det(tempA) / det(A)
    disp('------')
end
X

toc
end

