clear;
close all;

%------------------------ initialize parameters ----------------------
global test_accuracy Lambda_N1_N2
d = 0.1; % default diameter
n_medium = 1.3; % default refractive index of the medium (water)
lambda_0_start = 0.4; % um
lambda_0_end = 0.8; % um
N = 200;
Material = 'Au'; % 'Au' 'Polystyrene' 'Na' 'Fe' 'Ag'


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


d1 = [0.01, 0.03, 0.04, 0.1]; % um
for dd = d1
    Q = Q_vs_wavelength(Lambda_0, dd, n_medium, dependent_index);
    Cross_section = Q*(dd/2)^2*pi;
    %Nor_Cs = Cross_section  % do not normalize
    Nor_Cs = Cross_section / max(Cross_section);
    plot(Lambda_0*1000,Nor_Cs,'LineWidth',2,'DisplayName',['d = ', num2str(dd*1000),'nm']) 
    hold on
    

end
legend('show');

title(['Scattering Cross Section (SCS)',' vs wavelength',' (n medium = ',num2str(n_medium),')'],'FontSize', 13)
ylabel('Normalized SCS','FontSize', 18)
xlabel('wavelength(nm)','FontSize', 18)




