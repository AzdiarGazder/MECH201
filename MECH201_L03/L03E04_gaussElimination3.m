function L03E04_gaussElimination3

clc; clear all; clear hidden; close all

tic
%% Given 2 linear algebraic equations

% % 0.0003*x1  + 3*x2 = 2.0001    --- Eq.(1)
% %      1*x1  + 1*x2 = 1         --- Eq.(2)
% %
% %
% % This can be re-written in matrix form as:
% % |0.0003   3|   |x1|    |2.0001|    --- Eq.(1)
% % |     1   1| * |x2| =  |1     |    --- Eq.(2)
% %


%% ---
format default
disp('___________________________________________________________________')
A = [0.0003  3;...
    1      1]

B = [2.0001;...
    1]

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

tic
disp('___________________________________________________________________')
disp('Effect of significant figures')
disp('------')
T = table(); % create an empty table
tempTable = table();
format long
for sigFig = 3:15
    X2 = round((2/3) * 10^sigFig) / 10^sigFig;
    X1 = round(((2.0001 - (3*X2))/0.0003) * 10^sigFig) / 10^sigFig;
    err = 100*abs((X(1) - X1)/X(1));

    % Build a table within the main loop without preallocation
    tempTable.sigFig = sigFig;
    tempTable.X2 = X2;
    tempTable.X1 = X1;
    tempTable.error = err;
    T = [T;tempTable]; % append to table
    %---
end

format default
T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
T.Properties.VariableNames =  {'sigFig','X2','X1','error'}; % rename the columns to remove "Fun_" in the header
disp(T); % show the table in the command window
toc

end
