function result = My_Miecoated(m1,m2,a,c,lambda)
% This function is for easy calling Miecoated from the experiment value
% m1, m2 are complex relative refractive index of kernel and coating a is
% the inner radius, c is the thickness of the coating, lambda is the
% vacuum wavelength of the incident light
% result: a vector include all the Q efficiencies

n_water = 1.33;
m1 = m1 / n_water;
m2 = m2 / n_water;

k = 2*pi/lambda;  % calculate the wavenumber
b = a - c;  % calculate the outer radius
x = a*k; 
y = b*k;
opt = 1;  % choose option 1 (for detail, see instruction pdf)
result = Miecoated(m1,m2,x,y,opt);
