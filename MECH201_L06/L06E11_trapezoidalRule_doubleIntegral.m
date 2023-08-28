function L06E11_trapezoidalRule_doubleIntegral
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://stackoverflow.com/questions/35528972/matlab-double-integral-using-trapezoidal-rule
%
%%


%%
clc; clear all; clear hidden; close all

T = @(x,y) 2.*x.*y + 2.*x - x.^2 - 2.*y.^2 +72; % define a function that contains 2 variables

xMin = 0;   % define the lower bound
xMax = 8;   % define the uppper bound

yMin = 0;   % define the lower bound
yMax = 6;   % define the uppper bound

nX = 3;                       % define a number of points to plot
nY = 3;

x = linspace(xMin,xMax,nX+1);   % define **EQUALLY** spaced x & y -values
                                % between the bounds
y = linspace(yMin,yMax,nY+1);

stepSizeX = (xMax - xMin) / nX; % the width is the same for **EQUALLY**
                                % spaced x & y -values between the bounds
stepSizeY = (yMax - yMin) / nY;

% % In the 1D trapezoidal rule, the function values are multiplied by 
% % h/2, h, h, ..., h, h/2 where h is the step size. 
% % These are the weights of this integration rule. 
% % 
% % When an integration rule is applied in 2D, the weights get multiplied. 
% % In general, the step sizes may be different along the two dimensions,  
% % hX and hY, and the weights will be hX * hY multiplied by the following 
% % numbers:
% % 
% % 1/4 1/2 1/2 1/2 1/4
% % 1/2  1   1   1  1/2
% % 1/2  1   1   1  1/2
% % 1/4 1/2 1/2 1/2 1/4
% % 
% % A quick way to implement this is to:
% % - add all the values,
% % - subtract 1/2 of the values on all sides (this subtracts the corners twice), 
% % - then add 1/4 to the 4 corner values. 
% % 
% % meshgrid is used to set up the grid for evaluation of the surface
[X,Y] = meshgrid(x,y);
Tmtx = T(X,Y); % create the temperature matrix via substitution
% % 
% % sum is used for double summation. 
trapVol = stepSizeX * stepSizeY *...
    (sum(Tmtx(:)) -...
    0.5*(sum(Tmtx(1,:) + Tmtx(end,:)) + sum(Tmtx(:,1) + Tmtx(:,end))) +...
    0.25*(Tmtx(1,1) + Tmtx(1,end) + Tmtx(end,1) + Tmtx(end,end)));

% % Calculate the volume under the curve via integration
integratedArea = integral2(T,xMin,xMax,yMin,yMax);

% % The error between the 2 methods
err = 100*abs((integratedArea - trapVol) / integratedArea);

disp('___________________________________________________________________')
disp('The volume under the curve via:')
disp(['Scripting using the 2D trapezoidal rule  = ',num2str(trapVol)]);
disp(['MATLAB''s integrated volume function      = ',num2str(integratedArea)]);
disp('----')
disp(['error (%)                                = ',num2str(err)]);
disp('----')
disp(['Average temperature                      = ',num2str(trapVol/((xMax - xMin)*(yMax - yMin)))]);
disp('___________________________________________________________________')


figure
surf(X,Y,Tmtx); 
hold all
xlabel('X');
ylabel('Y');
zlabel('Z = f(X,Y)');
box on;
grid on;
view(-45, 45);
hold off;

end



