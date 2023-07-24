function L03E04_gaussElimination1

clc; clear all; clear hidden; close all


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


%% ---
disp('___________________________________________________________________')
A = [0.3   0.52      1;...
    0.5      1    1.9;...
    0.1    0.3    0.5]

B = [-0.01;...
    0.67;...
    -0.44]

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
disp('Using a custom Gauss elimination script')
disp('------')
disp('PART 1: Transforming to an upper triangular system via Gaussian elimination')
disp('------')
AA = A
BB = B
disp('------')
lgthAA = length(AA);
for ii = 1:(lgthAA-1)
    for  jj = lgthAA: -1: (ii+1)
        disp(['row numbers = ',num2str(jj),' & ',num2str(ii)]);
        factor = AA(jj,ii) / AA(ii,ii);
        disp(['factor = ', num2str(AA(jj,ii)), ' / ', num2str(AA(ii,ii)), ' = ', num2str(factor)]);
        disp(['AA(', num2str(jj), ',:) = AA(', num2str(jj), ',:) - (', num2str(factor), ' * AA(',num2str(ii),',:))']);
        AA(jj,:) = AA(jj,:) - factor*AA(ii,:)
        disp(['BB(', num2str(jj), ') = BB(', num2str(jj), ') - (', num2str(factor), ' * BB(',num2str(ii),'))']);
        BB(jj) = BB(jj) - factor*BB(ii)
        disp('------')
    end
end

disp('PART 2: Back substitution')
disp('------')
AA
BB
X = zeros(lgthAA,1)
disp('------')

X(lgthAA) = BB(lgthAA) / AA(lgthAA,lgthAA);
for ii = (lgthAA - 1) : -1 : 1
    AA
    BB
    X

    disp(['X(',num2str(ii), ') = BB(',num2str(ii),') - sum(X(',num2str(ii+1),':',num2str(lgthAA),')'' .* AA(',num2str(ii),',',num2str(ii+1),':',num2str(lgthAA),')) / AA(',num2str(ii),',',num2str(ii),')']);
    X(ii) = (BB(ii) - sum(X(ii+1:lgthAA)' .* AA(ii, ii+1:lgthAA))) / AA(ii,ii);

    oriTxt1 = num2str(X(ii+1:lgthAA)'); newTxt1 = regexprep(oriTxt1,' +',' '); % removes all but one blank space
    oriTxt2 = num2str(AA(ii,ii+1:lgthAA)); newTxt2 = regexprep(oriTxt2,' +',' '); % removes all but one blank space
    disp([num2str(X(ii)), ' = (',num2str(BB(ii)), ' - sum([',newTxt1,'] .* [', newTxt2,'])) / ',num2str(AA(ii,ii))]);
    disp('------')
end
X
toc
end

