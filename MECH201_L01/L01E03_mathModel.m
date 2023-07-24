function L01E03_mathModel

clc; clear all; clear hidden; close all

% % Fd = (m1 + m2)*g = m*g       = gravitational force
% % Fu = -c*v                    = drag force
% % F = Fd + Fu                  = total force
% % F = m*g - c*v                --- eq(1)
% %
% % Based on Newton's second law of motion
% % F = m*a
% % Or, F = m*(dv/dt)
% % Or, dv/dt = F/m              --- eq(2)
% %
% % Substituting eq(1) into eq(2)
% % dv/dt = (m*g - c*v)/m 
% % dv/dt = g - ((c/m)*v)

tic
disp('-------')
% % Define the differential equation describing the equation of motion
syms v(t) g c m % define the symbols in the ordinary differential eqN (ODE)
eq = diff(v,t) == g - ((c/m)*v) % define the ODE

% % Assuming that the parachute opens immediately at t = 0 so that the
% % equation "eq" is valid for all values of t >= 0.
% % Solve the differential equation analytically using dsolve with the
% % initial condition v(0) == 0.
% % This solution represents the instantaneous velocity of the paratrooper
% as a function of time.
cond = v(0) == 0;
vSolN(t) = simplify(dsolve(eq,cond)) % solve for v

% % vSolN(t) = (g*m - g*m*exp(-(c*t)/m))/c        = MATLAB output
% % Or, vSolN(t) = ((m*g)/c)*(1 - exp(-(c/m)*t))
disp('-------')
toc

end


