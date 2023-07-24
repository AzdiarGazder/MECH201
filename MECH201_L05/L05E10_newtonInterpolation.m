function L05E10_newtonInterpolation

clc; clear all; clear hidden; close all

% General form of Newton's Divided Difference Interpolation Method for polynomials
x = [1, 4, 6]
fx = log(x)


disp('___________________________________________________________________')
n = length(fx);
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
pstr

disp('----')
disp('...or in MATLAB symbolic format as:')
syms x f(x);
f(x) = simplify(str2sym(pstr))

disp('----')
disp(['...such that for x = 2 ; f(x) = ',num2str(double(f(2)))])

disp('___________________________________________________________________')

end
