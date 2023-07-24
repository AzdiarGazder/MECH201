function L03E02_matrixRules

clc; clear all; clear hidden; close all

tic
A = randi([-5,5],3,3)


%% ---
disp('___________________________________________________________________')
disp('Matrix determinant')
det(A)


%% ---
disp('___________________________________________________________________')
disp('Matrix inverse')
invA = inv(A)
prod = A * invA

%% ---
disp('___________________________________________________________________')
disp('Matrix transpose')
A = transpose(A)


%% ---
disp('___________________________________________________________________')
disp('Matrix scalar multiplication')
A = 3*A


%% ---
disp('___________________________________________________________________')
disp('Matrix scalar division')
A = A/3


%% ---
disp('___________________________________________________________________')
A = randi([-5,5],4,4)
B = randi([-10,10],4,4)


%% ---
disp('------')
disp('Matrix equality')
logicAnswer = isequal(A,B)


%% ---
disp('------')
disp('Matrix addition')
C = A + B


%% ---
disp('------')
disp('Matrix subtraction')
C = A - B


%% ---
disp('------')
disp('Matrix element multiplication')
C = A .* B

%% ---
disp('___________________________________________________________________')
% A = randi([-5,5],3,2)
% B = randi([-10,10],2,2)
A = [3 1;...
    8 6;...
    0 4]

B = [5 9;...
    7 2]

%% ---
disp('------')
disp('Matrix product multiplication')
C = A * B

end
