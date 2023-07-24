function L05E13_bilinearInterpolation

clc; clear all; clear hidden; close all

% General form for bilinear interpolation of a function
% % Script modified from:
% % https://au.mathworks.com/matlabcentral/fileexchange/10772-fast-2-dimensional-interpolation

% % Define the X & Y co-ordinates and Z values of a function
xx = linspace(-2,2,500); yy = xx;
[X,Y] = meshgrid(xx,yy);
Z = X.*exp(-X.^2-Y.^2);
disp('___________________________________________________________________')
[~,ind] = max(Z(:));
disp('Co-ordinates of the function @ Z_max')
disp(['X = ',num2str(X(ind))]);
disp(['Y = ',num2str(X(ind))]);
disp(['Z = ',num2str(Z(ind))]);


% % Using the X & Y co-ordinates of Z_max, calculate the value of Z 
% via bilinear interpolation. See if they match.
xx0 = X(ind); yy0 = Y(ind);
[X0,Y0] = meshgrid(xx0,yy0);

% % Get X and Y array spacing
fSize = size(X);
ndx = 1/(X(1,2)-X(1,1));
ndy = 1/(Y(2,1)-Y(1,1));

% % Begin mapping xi and yi vectors onto index space by subtracting library
% % array minima and scaling to index spacing
X0 = (X0 - X(1,1))*ndx;
Y0 = (Y0 - Y(1,1))*ndy;

% % Fill Zi with NaNs
Zi = NaN * ones(size(X0));

% % Transform to a unit square
fxi = floor(X0) + 1; % x_i
fyi = floor(Y0) + 1; % y_i
dfxi = X0 - fxi + 1;
dfyi = Y0 - fyi + 1;     % Location within the unit square

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
disp('Z_max found from bilinear interpolation')
disp(['Zi    = ',num2str(Zi)])
disp(['error = ',num2str(abs((Z(ind)-Zi)/Z(ind)))])
disp('___________________________________________________________________')


%% Plot the data
figure
% % Plot the function
mesh(X,Y,Z);
hold all;

% % Plot the interpolated point
plot3(xx0,yy0,Zi,'o','MarkerFaceColor',[1 0 0], ...
    'MarkerEdgeColor',[0 0 0]);
hold off;
xlabel('X');
ylabel('Y');
zlabel('Z');


end
