function L06E01_trapezoidalRule
%% Function description:
%
%
%% Author:
% Dr. Azdiar Gazder, 2023, azdiaratuowdotedudotau
%
%% Acknowledgements:
% Script modified from:
% https://au.mathworks.com/matlabcentral/answers/364905-trapezoidal-numerical-integration-without-use-of-function
%
%%


% % Given: 
% % f(a) = A*a + B
% % 
% % and 
% % 
% % f(b) = A*b + B
% % 
% % Step 1: To calculate A
% % f(b) - f(a)
% % 
% % f(b) - f(a) = A*b + B - (A*a + B)
% % f(b) - f(a) = A*b + B - A*a - B
% % f(b) - f(a) = A*b - A*a + B - B % re-arranging with +B and -B cancelling each other out
% % f(b) - f(a) = A*(b - a)
% % or, A = (f(b) - f(a)) / (b - a)
% % 
% % Step 2: To calculate B
% % b*f(a) - a*f(b)
% % 
% % b*f(a) - a*f(b) = b*(A*a + B) - a*(A*b + B)
% % b*f(a) - a*f(b) = b*A*a + b*B - a*A*b - a*B
% % b*f(a) - a*f(b) = b*A*a + b*B - a*A*b - a*B
% % b*f(a) - a*f(b) = a*A*b - a*A*b + b*B - a*B % re-arranging
% % b*f(a) - a*f(b) = B*(b - a) % re-arranging
% % or, B = (b*f(a) - a*f(b)) / (b - a)
% % 
% % 
% % Now, given 2 equations:
% % A = (f(b) - f(a)) / (b - a)
% % B = ((b * f(a)) - (a * f(b))) / (b - a)
% % 
% % Show that:
% % (A * ((b*b - a*a) / 2)) + (B * (b - a)) = (b - a) * ((f(a) + f(b)) / 2)
% % 
% % Step 1: Substitute the expressions for A and B into the LHS
% % = (((f(b) - f(a)) / (b - a)) * ((b*b - a*a) / 2)) + ((((b * f(a)) - (a * f(b))) / (b - a)) * (b - a))
% % 
% % Step 2:The (b - a) term in the numerator and denominator of the second term cancel each other out
% % = (((f(b) - f(a)) * (b*b - a*a)) / (2*(b - a)) + ((b * f(a)) - (a * f(b)))
% % 
% % Step 3: Expand the expression (b^2 - a^2) as equal to (b + a) * (b - a) and substitute it into the first term
% % = (((f(b) - f(a)) * (b + a) * (b - a)) / (2*(b - a))) + ((b * f(a)) - (a * f(b)))
% % 
% % Step 4:The (b - a) term in the numerator and denominator of the first term cancel each other out
% % = (((f(b) - f(a)) * (b + a)) / 2) + ((b * f(a)) - (a * f(b)))
% % 
% % Step 5: Calculating a common denominator
% % =  (((f(b) - f(a)) * (b + a))  + (2 * f(a) * b) - (2 * f(b) * a)) / 2
% % 
% % Step 6: Expanding the numerator
% % (f(b) * b + f(b) * a - f(a) * b - f(a) * a + (2 * f(a) * b) - (2 * f(b) * a)) / 2
% % 
% % Step 7: Rearranging the numerator by putting common terms together
% % (f(b) * b + f(b) * a - (2 * f(b) * a) - f(a) * b + (2 * f(a) * b) - f(a) * a) / 2
% % 
% % Step 8: The equation reduces to
% % (f(b) * b - f(b) * a + f(a) * b - f(a) * a) / 2
% % 
% % Step 9: Factoring out f(a) from the first two terms and f(b) from the last two terms
% % (f(b)*(b - a) + f(a)(b - a)) / 2
% % 
% % Step 10: Factoring out (b - a) from the two terms
% % (b - a)* (f(b) + f(a)) /2  ...The RHS proof


%%
clc; clear all; clear hidden; close all

f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5; % define a function

xMin = 0;   % define the lower bound
xMax = 0.8; % define the uppper bound

% % APPROACH 1: The area of a trapezoid using scripting
% % Here the area of a trapezoid is defined as:
% % a small but constant width between pairs of points along the x-axis (or stepSize)
% % i.e. - (b - a)
% % 
% % multiplied by
% % 
% % the average of the trapezoid heights for each pair of points
% % i.e. - (f(a) + f(b)) /2
% % 
n = 1; % use 1 or 100         % define the number of points to plot
x = linspace(xMin,xMax,n+1);  % define **EQUALLY** spaced x-values 
                              % between the bounds
stepSize = (xMax - xMin) / n; % the width is the same for **EQUALLY** 
                              % spaced x-values between the bounds
trapArea = sum(stepSize * ((f(x(1:end-1)) + f(x(2:end))) / 2));


% % APPROACH 2: Using MATLAB's inbuilt trapezoid area function
trapzArea = trapz(x, 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5);


% % APPROACH 3: Calculate the area under the curve via integration
integratedArea = integral(@(x)f(x),xMin,xMax);


% % The errors between Approaches 1, 2 and 3
err_trapz = 100*abs((trapzArea - trapArea) / trapzArea);
err_int = 100*abs((integratedArea - trapArea) / integratedArea);
err_trapzInt = 100*abs((integratedArea - trapzArea) / integratedArea);


disp('___________________________________________________________________')
disp('For the trapezoidal rule, the area under the curve via:')
disp(['Scripting                                     = ',num2str(trapArea)]);
disp(['MATLAB''s in-built "trapz" function            = ',num2str(trapzArea)]);
disp(['MATLAB''s integrated area function             = ',num2str(integratedArea)]);
disp('----')
disp(['error between Scripting   and "trapz"    (%)  = ',num2str(err_trapz)]);
disp('----')
disp(['error between Scripting and integration  (%)  = ',num2str(err_int)]);
disp('----')
disp(['error between "trapz" & integration      (%)  = ',num2str(err_trapzInt)]);

disp('___________________________________________________________________')

figure
plot(x,f(x(1:end)),'o-r','lineWidth',2)
legend('f(x)','Location','northwest');
xlabel('X');
ylabel('Y = f(X)');

end
