a = 200;  % inner radius
C = 0.01:10:41;  % thickness of the coating
N = length(C);

lambda = 400:1:800;  % check missed features due to large steps

m1 = 1.59;  % refractive index of the core
m2 = 1.6+0.3i;  % refractive index of the coating

lg = cell(1,N);
figure()
for i=1:N
    c = C(i);
    Q = My_plot_Q_over_lambda(m1,m2,a,c,lambda);
    plot(lambda,Q)
    
    lg{i} = ['c = ',num2str(floor(c)),'nm'];
    hold on
end

legend(lg)