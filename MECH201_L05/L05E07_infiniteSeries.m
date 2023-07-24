function L05E07_infiniteSeries

clear all; close all; clc

%% Define an infinite series equation 
% For each term in the equation:
% - the sign alternates between negative & positive for even & odd numbered
% terms, respectively, and
% - tha velue of the odd numbered constants within each term increases 
% incrementally per term 

syms omega0 t n
F = (4/(n.*pi)).*cos(n.* omega0 .* t); % define the smallest term making up the infinite series
sumEq = 0; % define a zero sum equation
seriesLength = [1:2:250]; % define an odd numbered array comprising the length of the infinite series

% Calculate the infinite series for the defined length
for jj = 1:length(seriesLength)
    if ~mod(jj,2)
        sumEq = sumEq - symsum(F,n,seriesLength(jj),seriesLength(jj)); % for even jj
      else
          sumEq = sumEq + symsum(F,n,seriesLength(jj),seriesLength(jj)); % for odd jj
    end
end
pretty(sumEq) % display the infinite series in symbolic form


%% Experimental data
T = 25;            % wavelength
time = 0:0.1:100;  % time in seconds

% Numerically calculate the values at each time step
for ii = 1:length(time)
    iV = subs(sumEq,[omega0,t],[2*pi()/T, time(ii)]); % replacing angular frequency and time step
    Ft(ii) = double(vpa(iV));
end

figure
plot(time,Ft,'-r','lineWidth',2);
xlabel('time (seconds)')
ylabel('f(t)')
legend({'Experimental data'},...
    'Location','southeast')
hold off;

end