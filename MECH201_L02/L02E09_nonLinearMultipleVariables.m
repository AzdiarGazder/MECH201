function L02E09_nonLinearMultipleVariables
% Author: Azdiar Gazder

clc; clear all; clear hidden; close all

disp('-------')
% Define non linear multiple variable equations
syms u v x y;
u(x,y) = x^2 + x*y - 10;
v(x,y) = y + 3*x*y^2 - 57;
disp(['u(x,y) = ',sym2str(u(x,y)),' = 0']);
disp(['v(x,y) = ',sym2str(v(x,y)),' = 0']);
disp('-------')

% Find the partial derivatives
du_dx = diff(u(x,y),x);
du_dy = diff(u(x,y),y);
disp(['du/dx = ',sym2str(du_dx)]);
disp(['du/dy = ',sym2str(du_dy)]);
disp('-------')

dv_dx = diff(v(x,y),x);
dv_dy = diff(v(x,y),y);
disp(['dv/dx = ',sym2str(dv_dx)]);
disp(['dv/dy = ',sym2str(dv_dy)]);
disp('-------')

x0 = 1.5; % initial guess
y0 = 3.5; % initial guess

maxIter = 1000;    % maximum number of iterations
tol = 1E-4;        % tolerance in lecture notes = 0.5% = 5E-3;
solNFound = false; % flag for solution

T = table(); % create an empty table
tempTable = table();

% Main loop
tic
for iter = 1:maxIter
    u_val = double(subs(u(x,y),{x,y},{x0,y0}));
    v_val = double(subs(v(x,y),{x,y},{x0,y0}));

    dudx_val = double(subs(du_dx,{x,y},{x0,y0}));
    dudy_val = double(subs(du_dy,{x,y},{x0,y0}));

    dvdx_val = double(subs(dv_dx,{x,y},{x0,y0}));
    dvdy_val = double(subs(dv_dy,{x,y},{x0,y0}));

    xi = x0 - (((u_val*dvdy_val) - (v_val*dudy_val))/((dudx_val*dvdy_val) - (dudy_val*dvdx_val)));
    yi = y0 - (((v_val*dudx_val) - (u_val*dvdx_val))/((dudx_val*dvdy_val) - (dudy_val*dvdx_val)));

    errX = abs((xi-x0)/xi);
    errY = abs((yi-y0)/yi);

    % Build a table within the main loop without preallocation
    tempTable.iter = iter;
    tempTable.x0 = x0;
    tempTable.y0 = y0;
    tempTable.xi = xi;
    tempTable.yi = yi;
    tempTable.errX = errX;
    tempTable.errY = errY;
    T = [T;tempTable]; % append to table
    %---

    if errX <= tol && errY <= tol % solution was found
        solNFound = true;
        x0 = xi;
        y0 = yi;
        break;
    end

    x0 = xi;
    y0 = yi;
end

% Display the results
if solNFound % if solution found
    T = varfun(@(x) num2str(x,['%' sprintf('.%df',6)]), T); % set the number of decimal points to display in the table
    T.Properties.VariableNames =  {'iter','x0','y0','xi','yi','errX','errY'}; % rename the columns to remove "Fun_" in the header
    disp(T); % show the table in the command window

    disp('-------')
    disp('Solution found.')
    disp(['Newton-Raphson converged in ',num2str(iter), ' iteration(s).'])
    disp(['Root x = ',num2str(x0)]);
    disp(['Root y = ',num2str(y0)]);
    disp(['u(x,y) at roots = ', num2str(double(subs(u(x,y),{x,y},{x0,y0})))]);
    disp(['v(x,y) at roots = ', num2str(double(subs(v(x,y),{x,y},{x0,y0})))]);
    disp('-------')

else % if no solution found
    error('No solution. Newton-Raphson did not converge in %d iteration(s).', maxIter);
end
toc

errorX = arrayfun(@(x) str2double(x), string(T.errX));  % convert table columns to double array
plot(1:length(errorX),errorX,'o-r','LineWidth',2,'DisplayName',['Newton-Raphson x']);
hold all;
errorY = arrayfun(@(x) str2double(x), string(T.errY));  % convert table columns to double array
plot(1:length(errorY),errorX,'sq--b','LineWidth',2,'DisplayName',['Newton-Raphson y']);
xlabel('iteration (s)')
ylabel('error (abs)')
legend('location','northeast')
hold off;

end




function [out] = sym2str(sy)
% Updated:  02-03-2009
% Author: Marty Lawson
%
% Converts symbolic variables to a matlab equation string insuring that
% only array opps are used.
% Symbolic arrays are converted to linear cell arrays of strings.
% This function is especially useful when combined with the eval() command.
% Also, converts maple atan function to matlab atan2 and converts
% maple "array([[a,b],[c,d]])" notation to matlab "[a,b;c,d]" notation.
%
% Note 1: eval() of a matrix of functions only works if all the input
% variables have single values.  i.e. vectors and arrays won't work.
%
% Note 2: eval() does not work on cell arrays directly.
% Use "Cell_array{index}" inside of the eval() to keep eval() happy
%
% EXAMPLE:
%
% X_t = dsolve('5*D2x+6*Dx+3*x = 10*sin(10*t)','x(0)=0','Dx(0)=3'); % solution is a symbolic function, X(t)
% X_t_str = sym2str(X_t);							                % convert from symbolic type to char type using array operations
% t = 0:.01:20;									                    % make "t" an array containing the time range of interest for X(t)
% X_t_vec = eval(X_t_str);							                % see "help eval" for details.
% plot(t,X_t_vec)									                % plot the results
% grid on										                    % make the plot look nice
% xlabel('time [radians]')
% ylabel('amplitude [-]')
%
sy = sym(sy); % ensure input is symbolic
siz = prod(size(sy));   % find the number of elements in "sy"
for i = 1:siz   % dump it into a cell array with the same number of elements
    in{i} = char(sy(i)); % convert to char
    in{i} = strrep(in{i},'^','.^'); % insure that all martix opps are array opps
    in{i} = strrep(in{i},'*','.*');
    in{i} = strrep(in{i},'/','./');
    in{i} = strrep(in{i},'atan','atan2'); % fix the atan function
    in{i} = strrep(in{i},'array([[','['); % clean up any maple array notation
    in{i} = strrep(in{i},'],[',';');
    in{i} = strrep(in{i},']])',']');
end
if siz == 1
    in = char(in); % revert back to a 'char' array for single answers
end
out = in;
end