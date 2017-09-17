function Q = My_plot_Q_over_lambda(m1,m2,a,c,lambda)
% This function is for calculating the Q efficiency over the range of wavelength
% Might need to revise this to a wavelength dependent refrective index

N = length(lambda);
Q = zeros(N);

for i = 1:N
    Qs = My_Miecoated(m1,m2,a,c,lambda(i));
    Q(i) = Qs(2); % choose Q_sca
end
