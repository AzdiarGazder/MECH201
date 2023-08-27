function L06E16_improperIntegral
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%%

%%
clc; clear all; clear hidden; close all

syms x;
f = (1/(2*pi)).*exp(-x.^2/2);

vpa(int(f,-inf,1))

end
