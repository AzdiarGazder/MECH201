function L01E05_truncation

clc; clear all; clear hidden; close all

tic
x = sqrt(9.01) - 3;

%% ---
disp('------')
format short
disp('format short   = Scaled fixed point format with 5 digits.')
disp('format         = Default. Same as SHORT.')
% pi
x

%% ---
disp('------')
format long
disp('format long    = Scaled fixed point format with 15 digits.')
% pi
x

%% ---
disp('------')
format short e
disp('format short e = Floating point format with 5 digits.')
% pi
x

%% ---
disp('------')
format long e
disp('format long e  = Floating point format with 15 digits.')
% pi
x

%% ---
disp('------')
format short g
disp('format short g = Best of fixed or floating point format with 5 digits.')
% pi
x

%% ---
disp('------')
format long g
disp('format long g  = Best of fixed or floating point format with 15 digits.')
% pi
x

%% ---
disp('__________________________')
format long
% disp('format long')
% pi
x

sigDigits = 4  % specify the number of digits after the decimal point
% pi_ceil = ceil(pi * 10^sigDigits) / 10^sigDigits
% pi_round = round(pi * 10^sigDigits) / 10^sigDigits
% pi_floor = floor(pi * 10^sigDigits) / 10^sigDigits

x_ceil = ceil(x * 10^sigDigits) / 10^sigDigits
x_round = round(x * 10^sigDigits) / 10^sigDigits
x_floor = floor(x * 10^sigDigits) / 10^sigDigits
disp('__________________________')

toc

end