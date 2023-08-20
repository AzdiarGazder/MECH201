function L05E18_2DbilinearInterpolation
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/fileexchange/10772-fast-2-dimensional-interpolation
% 
%%


%%
clc; clear all; clear hidden; close all

% General form for bilinear interpolation of a function

% % Define the X & Y co-ordinates and Z values of a function
xx = linspace(-2,2,500); 
yy = xx;
[X,Y] = meshgrid(xx,yy);
Z = X.*exp(-X.^2-Y.^2);
disp('___________________________________________________________________')
[~,ind] = max(Z(:));
disp('Co-ordinates of the function @ Zmax')
Xmax = X(ind); Ymax = Y(ind); Zmax = Z(ind);
disp(['X = ',num2str(Xmax)]);
disp(['Y = ',num2str(Ymax)]);
disp(['Z = ',num2str(Zmax)]);

% % Get X and Y array spacing
fSize = size(X);
ndx = 1/(X(1,2) - X(1,1)); % step size in x
ndy = 1/(Y(2,1) - Y(1,1)); % step size in y


% % Begin mapping Xi and Yi vectors onto index space by subtracting library
% % array minima and scaling to index spacing
Xi = (Xmax - X(1,1)) * ndx;
Yi = (Ymax - Y(1,1)) * ndy;

% % Fill Zi with NaNs
Zi = NaN * ones(size(Xi));

% % Transform to a unit square
fxi = floor(Xi) + 1; % x_i
fyi = floor(Yi) + 1; % y_i
dfxi = Xi - fxi + 1;
dfyi = Yi - fyi + 1; % Location within the unit square

% % flagIn = logical to determine if the requested coordinate is inside
% % or outside the function arrays
flagIn = fxi > 0 & fxi < fSize(2) & ~isnan(fxi) &...
    fyi > 0 & fyi < fSize(1) & ~isnan(fyi);

% % Remove all out-of-bounds variables to save computaton time
fxi = fxi(flagIn);
fyi = fyi(flagIn);
dfxi = dfxi(flagIn);
dfyi = dfyi(flagIn);

% % Find the bounding vertices
ind1 = fyi + fSize(1)*(fxi-1);     % (x_i   , y_i)
ind2 = fyi + fSize(1)*fxi;         % (x_i+1 ,  y_i)
ind3 = fyi + 1 + fSize(1)*fxi;     % (x_i+1 , y_i+1)
ind4 = fyi + 1 + fSize(1)*(fxi-1); % (x_i   , y_i+1)

% % Bilinear interpolation
% % See http://en.wikipedia.org/wiki/Bilinear_interpolation
Zi(flagIn) = Z(ind1).*(1 - dfxi).*(1 - dfyi) + ...
    Z(ind2).*dfxi.*(1 - dfyi) + ...
    Z(ind4).*(1 - dfxi).*dfyi + ...
    Z(ind3).*dfxi.*dfyi;

disp('___________________________________________________________________')
disp('Z_max found from 2D bilinear interpolation')
disp(['Zi    = ',num2str(Zi)])
disp(['error = ',num2str(abs((Z(ind) - Zi) / Z(ind)))])
disp('___________________________________________________________________')


%% Plot the data
figure
% % Plot the function
mesh(X,Y,Z);
hold all;

% % Plot the max point
plot3(Xmax,Ymax,Zmax,'s','MarkerFaceColor',[1 0 0], ...
    'MarkerEdgeColor',[0 0 0],'MarkerSize',15);
hold all;
% % Plot the interpolated max point
plot3(Xmax,Ymax,Zi,'o','MarkerFaceColor',[0 0 1], ...
    'MarkerEdgeColor',[0 0 0],'MarkerSize',8);
hold off;
grid on;
box on;
xlabel('X');
ylabel('Y');
zlabel('Z');


end
