% plot the scs for different coating thickness

a = 294.7737;  % inner radius
C = 40:4:59;  % thickness of the coating
N = length(C);

lambda = 400:2:800;  % check missed features due to large steps

m1 = 1.5027;  % refractive index of the core
m2 = 1.7833;  % refractive index of the coating

lg = cell(1,N);
figure()
nor = 2;

for i=1:N
    c = C(i);
    Q = My_plot_Q_over_lambda(m1,m2,a,c,lambda,nor);
    plot(lambda,Q)
    
    lg{i} = ['c = ',num2str(floor(c)),'nm'];
    hold on
end

legend(lg)
xlabel('Wavelength','FontSize',14)
ylabel('Normalized SCS','FontSize',14)