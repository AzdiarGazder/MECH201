function L04E06_linearProgramingFormulation_simplex
%% Function description:
%  Basic Matlab implementation of the Simplex matrix algorithm by Nasser M. Abbasi
%
%% Author:
% Mohammad Daneshian
%
%% Modified by:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/85223-linear-programming-simplex-algorithm
% Script detailed explanation:
% https://www.12000.org/my_notes/simplex/index.htm
%
%%


%%
clc; clear all; clear hidden; close all

% Inequality constraint matrix (with slack variables in place)
A = [7, 11;...
    10, 8;...
    1, 0;...
    0, 1];
A = [A, eye(size(A,1))]; % Adding slack variables

% Inequality constraint values
b = [77;...
    80;...
    9;...
    6];

% Objective function coefficients
c = [-150, -175];
c = [c, zeros(1,size(A,1))]; % Adding slack variables


[A,b] = makeTableau(A,b);
tableau = simplex(A,b,c,'phase II');
printSolution(tableau);

end






% % =================================
function [A,b] = makeTableau(A,b)

[m,n] = size(A);
tableau = zeros(m+1, n+m+1);
tableau(1:m,1:n) = A;
tableau(end, n+1:end-1) = 1;
tableau(1:m, end) = b(:);
tableau(1:m, n+1:n+m) = eye(m);
fprintf('* The initial tableau is: \n');
disp(tableau);

for ii = 1:m % make all entries in the bottom row zero
    tableau(end,:) = tableau(end,:) - tableau(ii,:);
end

tableau = simplex(tableau(1:m, 1:n+m), tableau(1:m, end), tableau(end, 1:n+m),'phase I');
A = tableau(1:m, 1:n);
b = tableau(1:m, end);
end


% % =================================
function tableau = simplex(A,b,c,varargin)

[m, n] = size(A);
tableau = zeros(m+1, n+1);
tableau(1:m, 1:n) = A;
tableau(m + 1, 1:n) = c(:);
tableau(1:m, end) = b(:);


keepRunning = true;
while keepRunning
    fprintf('___________________________________________________________________\n');
    if any(strcmpi(varargin,'phase I'))
        fprintf('Phase I \n');
    elseif any(strcmpi(varargin,'phase II'))
        fprintf('Phase II \n');;
    end
    fprintf('----\n');
    fprintf('** The current tableau is: \n');
    disp(tableau);

    if any(tableau(end, 1:n) < 0) % check for a negative cost coefficient
        [~,JJ] = min(tableau(end, 1:n)); % if yes, find the most negative
        % now check if corresponding column is unbounded
        if all(tableau(1:m, JJ) <= 0)
            fprintf('----\n');
            error('The problem is unbounded. All entries <= 0 in column %d',JJ);
            % do row operations to make all entries in the column 0
            % except for the pivot row
        else
            pivotRow = 0;
            minFound = inf;
            for ii = 1:m
                if tableau(ii,JJ) > 0
                    tmp = tableau(ii,end) / tableau(ii,JJ);
                    if tmp < minFound
                        minFound = tmp;
                        pivotRow = ii;
                    end
                end
            end
            fprintf('----\n');
            fprintf('*** The pivot row number is: %d\n',pivotRow);
            % normalise
            tableau(pivotRow,:) = tableau(pivotRow,:) / tableau(pivotRow,JJ);
            % make all entries in column J = zero
            for ii = 1: (m + 1)
                if ii ~= pivotRow
                    tableau(ii,:) = tableau(ii,:) - sign(tableau(ii,JJ)) *...
                        abs(tableau(ii,JJ)) * tableau(pivotRow,:);
                end
            end
        end
        fprintf('----\n');
        fprintf('**** The current basic feasible solution is: \n');
        disp(getCurrentX());
    else
        keepRunning = false;
    end
end

% internal function to find the current basis vector
    function currentX = getCurrentX()
        currentX = zeros(n,1);
        for jj = 1:n
            if length(find(tableau(:,jj) == 0)) == m
                idx = tableau(:,jj) == 1;
                currentX(jj) = tableau(idx,end);
            end
        end
    end
end


% % =================================
function printSolution(tableau)

[nRow, nCol] = size(tableau);
A = tableau(1: nRow-1, 1: nCol-1);
b = tableau(1:nRow-1, nCol);
q = A ~= 0;
q = find(sum(q,1) == 1); % find all columns with one non-zero entry
solutionVector = zeros(nCol-1, 1);

for n = 1:length(q)
    jj = find(A(1:nRow-1, q(n)) == 1);
    if isempty(jj)
        solutionVector(q(n)) = 0;
    else
        solutionVector(q(n)) = b(jj);
    end
end

fprintf('___________________________________________________________________\n');
fprintf('**** The final solution is: \n');
disp(solutionVector)
fprintf('___________________________________________________________________\n');
end