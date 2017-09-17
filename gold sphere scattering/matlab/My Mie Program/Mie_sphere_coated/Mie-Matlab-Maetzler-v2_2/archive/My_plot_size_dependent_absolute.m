% plot the absolute scs for ph0 and ph7
% whose coating refractive index and thickness are obtained from the
% fitting, giving the corresponding data

a = 275.0982;  % inner radius
lambda = 400:1:800;  % check missed features due to large steps
m1 = 1.6;  % refractive index of the core

C = [55.5273, 53.0486];  % coating thickness for pH7 and pH0
M = [1.8278, 1.8684];  % coating refractive index for pH7 and pH0

figure()
nor = 0;  % do not normalize (absolute)

for i=1:2
    c = C(i);
    m = M(i);
    Q = My_plot_Q_over_lambda(m1,m2,a,c,lambda,nor);
    plot(lambda,Q)
   
    hold on
end

legend('pH7','pH0')
xlabel('Wavelength','FontSize',14)
ylabel('Normalized SCS','FontSize',14)