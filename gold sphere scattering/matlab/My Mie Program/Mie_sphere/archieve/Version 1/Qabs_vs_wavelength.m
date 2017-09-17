% This script gets the absorption efficiency of gold sphere in the water
% with the refractive index behaving as a function of incident wavelength.
% The wavelength range is restricted from 0.18um to 1.93um.

% load the data
load Lambda_N1_N2.txt
global Lambda N1 N2
Lambda = Lambda_N1_N2(:,1);
N1 = Lambda_N1_N2(:,2);
N2 = Lambda_N1_N2(:,3);

% initialization
lambda_0_start = 0.4; % um
lambda_0_end = 1; % um
N = 200;
Lambda_0 = linspace(lambda_0_start,lambda_0_end,N);
%a = 0.05; % um
Qabs = zeros(1,N);

i = 1;
for lambda_0 = Lambda_0
    Qabs(i) = qabs(lambda_0,a);
    i = i+1;
end

if a < 0.05
    plot(Lambda_0,Qabs,':','LineWidth',2)
else
    plot(Lambda_0,Qabs,'LineWidth',2)
end

title('Absorption Efficiency vs wavelength')
xlabel('wavelength (um)')
ylabel('Absorption Efficiency')
    