function Q = My_plot_Q_over_lambda(m1,m2,a,c,lambda, nor)
% This function is for calculating the Q efficiency over the range of wavelength
% Might need to revise this to a wavelength dependent refrective index
% nor: if nor == 0 then normalize the spectrum over a certain range 

sigma_g = pi * (a+c) * (a+c); % physical cross section

N = length(lambda);
Q = zeros(N,1);

for i = 1:N
    Qs = My_Miecoated(m1,m2,a,c,lambda(i));
    Q(i) = Qs(2) * sigma_g; % choose Q_sca
end

if nor==1  % normalize of the whole
    Q = Q/max(Q);
elseif nor ==2  % normalize over the peak
    Q = Q/max(Q(20:50));  % choose which part to normalize to
end