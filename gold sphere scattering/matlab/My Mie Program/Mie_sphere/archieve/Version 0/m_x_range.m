function [m, x_start,x_stop] = m_x_range(lambda_vacuum_start, lambda_vacuum_stop,a)
% this function is for calculating the m and the range of x for gold sphere,
% based on the incident wavelength (nm) and the radius (nm) of the gold
% sphere, the data of the gold refractive index was extracted from the file 
% lambda_n_k which was obtained from the website RefractiveIndex.INFO. 
% And the surrounding medium is water, whose refractive index was also 
% obtained from the same website, at the wavelength of 500nm.

% This is a easy-version, because the refractive index of the gold sphere
% is set to be a constant, at the average wavelength of the light in the
% medium

%----------------- calculate the x_range -------------------------
n_water = 1.3350;
lambda_water_start = lambda_vacuum_start/n_water;
lambda_water_stop = lambda_vacuum_stop/n_water;
x_start = a*2*pi/lambda_water_stop;
x_stop = a*2*pi/lambda_water_start;

%----------------- calculate m ------------------------------
% loading data
load Lambda_N1_N2.txt
lambda = Lambda_N1_N2(:,1)*1000;
N1 = Lambda_N1_N2(:,2);
N2 = Lambda_N1_N2(:,3);

% search the closest wavelength in the data
lambda_water_average = (lambda_water_start+lambda_water_stop)/2;
[~,index_2] = min(abs(lambda-lambda_water_average));
lambda_gold = lambda(index_2);
n_gold = N1(index_2);
k_gold = N2(index_2);

n_gold_complex = n_gold +1i*k_gold; 
disp(['the wavelength experienced by gold sphere is set to ',num2str(lambda_gold),'nm',]);


m = n_gold_complex/n_water; % complex relative refractive index of gold over water at the averaged wavelenth of the light in the water

