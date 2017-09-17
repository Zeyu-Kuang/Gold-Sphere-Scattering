function Qabs = qabs(lambda_0,a)
% This function is called by Qabs_vs_wavelength, where it calculates each
% individual absorption cross section for each value of wavelength, after
% interpolate m(wavelength)
n_water = 1.3;
lambda = lambda_0/n_water;
k = 2*pi/lambda;
x = k*a;

global Lambda N1 N2
n1 = interp1(Lambda,N1,lambda,'spline');
n2 = interp1(Lambda,N2,lambda,'spline');
n_gold = n1+1i*n2;

m = n_gold/n_water;

Q = Mie(m,x);
Qabs = Q(6);