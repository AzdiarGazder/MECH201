function L06E15_improperIntegral

syms x;
f = (1/(2*pi)).*exp(-x.^2/2);

vpa(int(f,-inf,1))

end
