function L03E07_LUdecomposition
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
tic
disp('___________________________________________________________________')
disp('Using default MATLAB functions')
% Factorise the full or sparse matrix A into:
% L = a permuted lower triangular matrix, and
% U = an upper triangular matrix from Gaussian elimination with partial
%     pivoting
% such that A = L*U
[L, U] = lu(A)
% % If solving for the linear algebra problem A*X = B, then
X = U \ (L \ B)
% % which is equivalent to X = A\B or X = inv(A)*B
toc

%% ---
tic
disp('___________________________________________________________________')
disp('Using a custom LU decomposition script')
disp('Given [A] = [L]*[U]...')
disp('such that [L]*[U]*[X] = [B]')
disp('where:')
disp('[U] is an upper triangular matrix calculated via Gaussian elimination')
disp('[L] is calculated via substituting the factors from Gaussian elimination into an identity matrix')
disp('Then...')
disp('[L]*[D] = [B] ...with [D] calculated via forward substitution')
disp('[U]*[X] = [D] ...with [X] calculated via backward substitution')
disp('------')
disp('PART 1: Transforming to an upper triangular system via Gaussian elimination')
disp('------')
disp('L = identity matrix')
L = eye(length(U))
disp('U = A')
U = A


disp('------')
lgthU = length(U);
for ii = 1:(lgthU-1)
    for  jj = lgthU: -1: (ii+1)
        disp(['row numbers = ',num2str(jj),' & ',num2str(ii)]);
        factor = U(jj,ii) / U(ii,ii);
        disp(['factor = ', num2str(U(jj,ii)), ' / ', num2str(U(ii,ii)), ' = ', num2str(factor)]);
        disp(['L(',num2str(jj),',',num2str(ii),') = ',num2str(factor)]);
        L(jj,ii) = factor
        disp(['U(', num2str(jj), ',:) = U(', num2str(jj), ',:) - (', num2str(factor), ' * U(',num2str(ii),',:))']);
        U(jj,:) = U(jj,:) - factor*U(ii,:)
        disp('------')
    end
end


disp('PART 2: Forward substitution')
disp('------')
L
B
D = zeros(lgthU,1)
disp('------')

D(1) = B(1) / L(1,1);
for ii = 2:lgthU
    L
    B
    D
    disp(['D(',num2str(ii), ') = B(',num2str(ii),') - sum(L(',num2str(ii),',1:',num2str(ii-1),') .* D(1:',num2str(ii-1),')'') / L(',num2str(ii),',',num2str(ii),')']);
    D(ii) = (B(ii) - sum(L(ii,1:ii-1) .* D(1:ii-1)')) / L(ii,ii);

    oriTxt1 = num2str(L(ii,1:ii-1)); newTxt1 = regexprep(oriTxt1,' +',' '); % removes all but one blank space
    oriTxt2 = num2str(D(1:ii-1)'); newTxt2 = regexprep(oriTxt2,' +',' '); % removes all but one blank space
    disp([num2str(D(ii)), ' = (',num2str(B(ii)), ' - sum([',newTxt1,'] .* [', newTxt2,'])) / ',num2str(L(ii,ii))]);
    disp('------')
end


disp('PART 3: Back substitution')
disp('------')
U
D
X = zeros(lgthU,1)
disp('------')

X(lgthU) = D(lgthU) / U(lgthU,lgthU);
for ii = (lgthU - 1) : -1 : 1
    U
    D
    X

    disp(['X(',num2str(ii), ') = D(',num2str(ii),') - sum(X(',num2str(ii+1),':',num2str(lgthU),')'' .* U(',num2str(ii),',',num2str(ii+1),':',num2str(lgthU),')) / U(',num2str(ii),',',num2str(ii),')']);
    X(ii) = (D(ii) - sum(X(ii+1:lgthU)' .* U(ii, ii+1:lgthU))) / U(ii,ii);

    oriTxt1 = num2str(X(ii+1:lgthU)'); newTxt1 = regexprep(oriTxt1,' +',' '); % removes all but one blank space
    oriTxt2 = num2str(U(ii,ii+1:lgthU)); newTxt2 = regexprep(oriTxt2,' +',' '); % removes all but one blank space
    disp([num2str(X(ii)), ' = (',num2str(D(ii)), ' - sum([',newTxt1,'] .* [', newTxt2,'])) / ',num2str(U(ii,ii))]);
    disp('------')
end
X
toc
end

%     2.0292
%    -3.0974
%    -7.2628
