function L03E06_gaussSeidel

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
disp('Using a custom Gauss-Seidel script')
disp('------')

lgthA = length(A);
X = zeros(lgthA,1)

maxIter = 15;      % maximum number of iterations
tol = 1E-4;        % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();
disp('------')
% Main loop
tic
for iter = 1:maxIter
    oldX = X;  % save current values to calculate error later
    disp('------')
    for ii = 1:lgthA
        disp(['X(',num2str(ii), ') = (B(',num2str(ii),') - sum(A(',num2str(ii),',:) * X(:)) + (A(',num2str(ii),',',num2str(ii),')* X(',num2str(ii),'))) / A(',num2str(ii),',',num2str(ii),')']);
        oriTxt1 = num2str(A(ii,:)); newTxt1 = regexprep(oriTxt1,' +',' '); % removes all but one blank space
        oriTxt2 = num2str(X(:)'); newTxt2 = regexprep(oriTxt2,' +',' '); % removes all but one blank space

        X(ii) = (B(ii) - sum(A(ii,:)*X(:)) + A(ii,ii)*X(ii)) / A(ii,ii);
        disp([num2str(X(ii)), ' = (',num2str(B(ii)), ' - sum([',newTxt1,'] .* [', newTxt2,']) + (',num2str(A(ii,ii)),'*',num2str(X(ii)),')) / ',num2str(A(ii,ii))]);
        disp('------')
    end
    err = abs((X - oldX)./X);

    % build a table within the main loop without preallocation
    tempTable.iter = iter;
    cell_oldX = num2cell(oldX'); cell_oldX = vertcat(cell_oldX{:});
    tempTable.oldX = cell_oldX';
    cell_X = num2cell(X'); cell_X = vertcat(cell_X{:});
    tempTable.X = cell_X';
    cell_err = num2cell(err'); cell_err = vertcat(cell_err{:});
    tempTable.error = cell_err';
    T = [T;tempTable]; % append to table
    %---

    if all(err <= tol) % solution found
        solNFound = true;
        x0 = X;
        break; % exit the loop
    end
end

% display the results
if solNFound % if solution found
%     T = varfun(@(x) num2str(x,['%' sprintf('.%df',4)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','x_old','x_new','err'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window
end

toc
end

% %     2.0292
% %    -3.0974
% %    -7.2628
