%------------------------ initialize parameters ----------------------
global test_accuracy Lambda_N1_N2
d = 0.03; % default diameter um
n_medium = 1.33; % default refractive index of the medium (water)
%Lambda = [222:1:1057]; %nm
Lambda = [400:1:800]; %nm
Lambda_0 = Lambda/1000; %um

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
pathname = '.\Refractive_index_data\';
Lambda_N1_N2 = load([pathname,filename]);
disp(['the input wavelength should lie inside the range ',num2str(Lambda_N1_N2(1,1)),'um -- ',num2str(Lambda_N1_N2(end,1)),'um'])

% --------------- plotting Q vs lambda with different d -------------------

Q = Q_vs_wavelength(Lambda_0, d, n_medium, dependent_index);
Cross_section = Q*pi*(d/2)^2;
Cross_section = Cross_section*1e6; % nm^2

%plot(Lambda,Cross_section/max(Cross_section),'LineWidth',2,'DisplayName',['diameter = ', num2str(d),'um']) % Cross section um^2
plot(Lambda,Cross_section,'LineWidth',2,'DisplayName',['diameter = ', num2str(d),'um']) % Cross section um^2

legend('show')
title(['Scattering Cross Section',' vs wavelength',' (n medium = ',num2str(n_medium),')'], 'FontSize', 13)
xlabel('wavelength (nm)', 'FontSize', 16)
ylabel('Scattering Cross Section (nm^2)', 'FontSize', 16)
h_lg = findobj (gcf, 'tag', 'legend');
set(h_lg,'FontSize',12)
%% -----writing--
data_pathname = pwd;
filename_Cross_section = ['Cross_section_',num2str(d*1000),'nm.txt'];
Cross_section_ID = fopen([data_pathname,'\',filename_Cross_section],'w'); 
fprintf(Cross_section_ID,'%6s %6s\r\n','# wavelength(nm)','Cross_section(nm^2)');
fprintf(Cross_section_ID,'%d %12.8f\r\n',[Lambda',Cross_section']');
fclose(Cross_section_ID);

