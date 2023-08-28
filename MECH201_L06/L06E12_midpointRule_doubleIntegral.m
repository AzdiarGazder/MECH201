function L06E12_midpointRule_doubleIntegral
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/183187-integration-in-2d-by-the-midpoint-rule
%
%%


%%
clc; clear all; clear hidden; close all

T = @(x,y) 2.*x.*y + 2.*x - x.^2 - 2.*y.^2 +72; % define a function that contains 2 variables

xMin = 0;   % define the lower bound
xMax = 8; % define the uppper bound

yMin = 0;   % define the lower bound
yMax = 6; % define the uppper bound

nX = 3;                       % define a number of points to plot
nY = 3;

x = linspace(xMin,xMax,nX+1);   % define **EQUALLY** spaced x & y -values
                                % between the bounds
y = linspace(yMin,yMax,nY+1);

stepSizeX = (xMax - xMin) / nX; % the width is the same for **EQUALLY**
                                % spaced x & y -values between the bounds
stepSizeY = (yMax - yMin) / nY;

midpointVol = 0;
for ii = 1:nX
    midPointX(ii) = (x(ii) + (x(ii) + stepSizeX)) / 2; % generate the list of X midpoints
    for jj = 1:nY
    midPointY(jj) = (y(jj) + (y(jj) + stepSizeY)) / 2; % generate the list of Y midpoints
    temp(ii,jj) = T(midPointX(ii), midPointY(jj));
    midpointVol = midpointVol + (stepSizeX * stepSizeY * temp(ii,jj)); % sum the area of the midpoints
    end
end

% % Calculate the volume under the curve via integration
integratedVol = integral2(T,xMin,xMax,yMin,yMax);

% % The error between the 2 methods
err = 100*abs((integratedVol - midpointVol) / integratedVol);

disp('___________________________________________________________________')
disp('The volume under the curve via:')
disp(['Scripting using the 2D midpoint rule   = ',num2str(midpointVol)]);
disp(['MATLAB''s integrated volume function    = ',num2str(integratedVol)]);
disp('----')
disp(['error (%)                              = ',num2str(err)]);
disp('----')
disp(['Average temperature                    = ',num2str(midpointVol/((xMax - xMin)*(yMax - yMin)))]);
disp('___________________________________________________________________')


[X,Y] = meshgrid(midPointX,midPointY);
X = X'; Y = Y';
% The mesh is purposely transposed because MATLAB's meshgrid function, by 
% default, fills row-wise first while looping column-wise second. 
% Consequently, in order to compare meshgrid Tmtx data (next command) to 
% the "temp" variable calculated above, the mesh needs to be transposed 
% beforehand.
Tmtx = T(X,Y); % create the temperature matrix via substitution

figure
surf(X,Y,Tmtx); 
hold all
surf(X,Y,temp); % compare against loop calculated values
xlabel('midPointX');
ylabel('midPointY');
zlabel('Z = f(midPointX, midPointY)');
box on;
grid on;
view(-45, 45);
hold off;

% deltaT = Tmtx - temp;

end



