function L05E14_newtonInterpolation
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/42135-newton-forward-difference-interpolating-polynomials
% 
%%


%%
clc; clear all; clear hidden; close all

% General form of Newton's Divided Difference Interpolation Method for polynomials
x = [1, 4, 6]
fx = log(x)


xx = x;
yy1 = fx;


disp('___________________________________________________________________')
n = length(fx);
x = x'
bb = zeros(n) % define an n * n matrix
bb(:,1) = fx  % such that bb(1,1) = b0
disp('----')
for col = 2:n
    for row = col:n
        disp(['bb(',num2str(row),',',num2str(col),') = (bb(',num2str(row),',',num2str(col-1), ') - bb(',num2str(row-1),',',num2str(col-1),')) / (x(',num2str(row),') - x(',num2str(row-col+1),'))']);
        bb(row, col) = (bb(row, col-1) - bb(row-1, col-1)) / (x(row) - x(row-col+1));
        disp([num2str(bb(row, col)), ' = (',num2str(bb(row, col-1)),' - ',num2str(bb(row-1, col-1)),') / (',num2str(x(row)),' - ',num2str(x(row-col+1)),')']);
        bb
        disp('----')
    end
end
disp('___________________________________________________________________')
bb
disp('----')
disp('The factors (b0...bn) for the qudratic equation');
disp('are the principal diagonal of the matrix "bb":')
b = diag(bb)


disp('___________________________________________________________________')
pstr = string(bb(1,1));
for row = 2:n
    if sign(bb(row,row)) == 1
        pstr = pstr + " + " + string(bb(row,row));
    else
        pstr = pstr + string(bb(row,row));
    end

    for col = 1:(row-1)
        pstr = pstr + " * (x - " + string(x(col)) + ") ";
    end
end
disp('The quadratic formula is expressed as:')
disp(pstr)

disp('----')
disp('...or in MATLAB symbolic format as:')
xx2 = min(x):0.1:max(x);
syms x f(x);
f(x) = simplify(str2sym(pstr))
yy2 = double(f(xx2));

disp('----')
disp(['...such that for x = 2 ; f(x) = ',num2str(double(f(2)))])

disp('___________________________________________________________________')


figure
plot(xx,yy1,'o-r','lineWidth',2); % experimental data points
hold all;
plot(xx2,yy2,'-k','lineWidth',2); % fitted data points
legend('f(x)','Newton interpolation','Location','southeast');
xlabel('X');
ylabel('Y = f(X)');

end
