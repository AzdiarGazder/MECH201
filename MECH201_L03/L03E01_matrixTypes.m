function L03E01_matrixTypes
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
myMatrix = randi([-5,5],4,4)


%% ---
disp('___________________________________________________________________')
disp('Identity matrix')
idMatrix = eye(size(myMatrix))


%% ---
disp('___________________________________________________________________')
disp('Diagonal matrix')
diagMatrix = diag(diag(myMatrix))


%% ---
disp('___________________________________________________________________')
disp('Upper triangular matrix')
utMatrix = triu(myMatrix)


%% ---
disp('___________________________________________________________________')
disp('Lower triangular matrix')
ltMatrix = tril(myMatrix)

%% ---
disp('___________________________________________________________________')
disp('Symmetric matrix = a_ij == a_ji.')
Mu = diagMatrix + triu(myMatrix,1) + triu(myMatrix,1)'   % upper matrix, copied to the lower half
Ml = diagMatrix + tril(myMatrix,-1) + tril(myMatrix,-1)' % lower matrix, copied to the upper half

end
