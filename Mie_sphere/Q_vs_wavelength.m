function Q = Q_vs_wavelength(Lambda_0, d, n_medium, dependent_index)

global test_accuracy

% calculate x vector
a = d/2;
lambda_medium = Lambda_0/n_medium;
k = 2*pi./lambda_medium;
x = k*a;

% calculate m vector
global Lambda_N1_N2
n1 = interp1(Lambda_N1_N2(:,1),Lambda_N1_N2(:,2),Lambda_0,'spine');
n2 = interp1(Lambda_N1_N2(:,1),Lambda_N1_N2(:,3),Lambda_0,'spine');
n_gold = n1+1i*n2;
m = n_gold/n_medium;

N = length(Lambda_0);
Q = zeros(1,N);
for i = 1:N
    Q_all = Mie(m(i),x(i));
    if test_accuracy
        Q_abs_method_2 = Mie_abs(m(i),x(i));
        Q_abs_method_1 = Q_all(dependent_index);
        Q(i) = Q_abs_method_2 - Q_abs_method_1;
        continue
    end
    Q(i) = Q_all(dependent_index);
end

    