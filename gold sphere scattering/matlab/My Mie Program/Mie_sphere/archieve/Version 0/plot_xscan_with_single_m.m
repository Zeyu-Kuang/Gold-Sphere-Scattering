% This script is using m_x_range to translate lambda, a to m, x. And then
% input m, x to function Mie_xscan to display the Mie efficiencies over the
% size parameter x
%
% Special note: This script is not suitable to study the responce of gold
% sphere to incident light field which contains more than one wavelength,
% because the refractive index of the gold particle is set to be a constant
% rather than a chanable complex number to different wavelength

lambda_vacuum_start = 400;% nm
lambda_vacuum_stop = 1000;% nm
a = 50;% nm

[m, ~,x_stop] = m_x_range(lambda_vacuum_start, lambda_vacuum_stop,a);

nsteps = 200;
dx = x_stop/nsteps;

Mie_xscan(m,nsteps,dx)