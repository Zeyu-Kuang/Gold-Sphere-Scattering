a = 294.7737;  % inner radius
C = 40:4:59;  % thickness of the coating
N = length(C);

c_m = 57.0872*1.7833;  % assume the production of m2 and c is constant

lambda = 400:1:800;  % check missed features due to large steps

m1 = 1.5027;  % refractive index of the core
%m2 = 1.9463;  % refractive index of the coating

lg = cell(1,N);
figure()
nor = 2;

for i=1:N
    c = C(i);
    m2 = c_m/c;
    Q = My_plot_Q_over_lambda(m1,m2,a,c,lambda,nor);
    plot(lambda,Q)
    
    lg{i} = ['c = ',num2str(floor(c)),'nm'];
    hold on
end

legend(lg)