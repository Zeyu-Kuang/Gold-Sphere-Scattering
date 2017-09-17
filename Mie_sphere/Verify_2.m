clear;
close all;

%------------------------ initialize parameters ----------------------
global test_accuracy Lambda_N1_N2
d = 0.05; % default diameter um
n_medium = 1.3; % default refractive index of the medium (water)
lambda_0_start = 0.4; % um
lambda_0_end = 0.8; % um
N = 200;
Material = 'Au'; % 'Au' 'Polystyrene' 'Na' 'Fe'
dependent_variable = 'Qext'; %'real(m)' 'imag(m)' 'x' 'Qext'
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

n1 = [1.00,1.33,1.50]; % refractive index

for nn = n1
    Q = Q_vs_wavelength(Lambda_0, d, nn, dependent_index);
    Q = Q*pi*(d/2*1e-6)^2; %m
    plot(Lambda_0*1000,Q,'LineWidth',2,'DisplayName',['n = ', num2str(nn,'%.2f')]) % now xlabel should have unit nm
    hold on

end
legend('show')
%title(['Extinction Cross Section',' vs. Wavelength',' (sphere diameter = ',num2str(d),')'],'FontSize',10)
title([' sphere diameter = ',num2str(d),'um'],'FontSize',14)
ylabel('Extinction Cross Section (m^2)','FontSize',14)
xlabel('Wavelength(nm)','FontSize',14)
ylim([0,2e-14])
