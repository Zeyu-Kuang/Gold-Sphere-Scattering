clear;
close all;

%------------------------ initialize parameters ----------------------
global test_accuracy Lambda_N1_N2
d = 0.1; % default diameter um
n_medium = 1.33; % default refractive index of the medium (water)
lambda_0_start = 0.4; % um
lambda_0_end = 1; % um
N = 200;
Material = 'Au'; % 'Au' 'Polystyrene' 'Na' 'Fe'
dependent_variable = 'Qsca'; %'real(m)' 'imag(m)' 'x' 'Qext'
                                %'Qsca' 'Qabs' 'Qb' 'asy' 'Qratio'
test_accuracy = 0;
if test_accuracy
    N = 20;
    dependent_variable = 'Qabs';
end
%------------------------- define dependent variable -------------------
result=strsplit('real(m) imag(m) x Qext Qsca Qabs Qb asy Qratio');
Dependent_Variables = containers.Map();
for i = 1:length(result)
    Dependent_Variables(result{i}) = i;
end
dependent_index = Dependent_Variables(dependent_variable);

%------- obtain conplex refractive index for the given material ------------
filename = ['Lambda_N1_N2_',Material,'.txt'];
pathname = 'F:\LINX LAB\gold sphere scattering\matlab\My Mie Program\Version 3\Refractive_index_data\';
Lambda_N1_N2 = load([pathname,filename]);
disp(['the input wavelength should lie inside the range ',num2str(Lambda_N1_N2(1,1)),'um -- ',num2str(Lambda_N1_N2(end,1)),'um'])

% --------------- plotting Q vs lambda with different a -------------------
Lambda_0 = linspace(lambda_0_start,lambda_0_end,N);% range of lambda

figure(1)
%set(figure(1), 'Position', [1 1 1920 1080])

d1 = 0.05:0.01:0.1; % um

for dd = d1
    Q = Q_vs_wavelength(Lambda_0, dd, n_medium, dependent_index);
    Q = Q*pi*(d/2*1e-6)^2; %m
    plot(Lambda_0*1000,Q,'LineWidth',2,'DisplayName',['d = ', num2str(dd),'um']) % now xlabel should have unit nm
    hold on

end
legend('show')
%title(['Scattering Cross Section',' vs. Wavelength',' (n medium = ',num2str(n_medium),')'],'FontSize',12)
title(['n medium = ',num2str(n_medium)],'FontSize',12)
ylabel('Scattering Cross Section (m^2)','FontSize',14)
xlabel('Wavelength(nm)','FontSize',14)

