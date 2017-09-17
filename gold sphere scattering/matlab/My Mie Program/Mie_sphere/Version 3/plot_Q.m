clear;
close all;

%------------------------ initialize parameters ----------------------
global test_accuracy Lambda_N1_N2
d = 0.1; % default diameter
n_medium = 1.3; % default refractive index of the medium (water)
lambda_0_start = 0.4; % um
lambda_0_end = 1; % um
N = 200;
Material = 'Au'; % 'Au' 'Polystyrene' 'Na' 'Fe' 'Ag'


dependent_variable = 'Qabs'; %'real(m)' 'imag(m)' 'x' 'Qext'
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
y_max = 0;
figure(1)
set(figure(1), 'Position', [1 1 1920 1080])

d1 = 0.01:0.02:0.1; % um
subplot(2,2,1)
for dd = d1
    Q = Q_vs_wavelength(Lambda_0, dd, n_medium, dependent_index);
    plot(Lambda_0,Q,'LineWidth',2,'DisplayName',['d = ', num2str(dd),'um']) 
    hold on
    
    if y_max < max(Q)
        y_max = max(Q);
    end
end
legend('show')
title([dependent_variable,' vs wavelength',' (n medium = ',num2str(n_medium),')'])

d2 = 0.1:0.02:0.20; % um
subplot(2,2,2)
for dd = d2
    Q = Q_vs_wavelength(Lambda_0, dd, n_medium, dependent_index);
    plot(Lambda_0,Q,'LineWidth',2,'DisplayName',['d = ', num2str(dd),'um'])
    hold on
    
    if y_max < max(Q)
        y_max = max(Q);
    end    
end
legend('show')
title([dependent_variable,' vs wavelength',' (n medium = ',num2str(n_medium),')'])

% ------------- plotting Q vs lambda with different n_medium --------------
n1_medium = 1.0:0.1:1.5;
d0 = 0.10;
subplot(2,2,3)
for nn_medium = n1_medium
    Q = Q_vs_wavelength(Lambda_0, d0, nn_medium, dependent_index);
    plot(Lambda_0,Q,'LineWidth',2,'DisplayName',['n = ', num2str(nn_medium)])
    hold on
    
    if y_max < max(Q)
        y_max = max(Q);
    end    
end
legend('show')
title([dependent_variable,' vs wavelength',' (d = ',num2str(d0),'um)'])

d0 = 0.025;
subplot(2,2,4)
for nn_medium = n1_medium
    Q = Q_vs_wavelength(Lambda_0, d0, nn_medium, dependent_index);
    plot(Lambda_0,Q,'LineWidth',2,'DisplayName',['n = ', num2str(nn_medium)])
    hold on
    
    if y_max < max(Q)
        y_max = max(Q);
    end
end
legend('show')
title([dependent_variable,' vs wavelength',' (d = ',num2str(d0),'um)'])

% -------------- set alike properties for 4 subplots ---------------
if test_accuracy
    output_label = 'Accuracy';
else
    output_label = dependent_variable;
end

for i = 1:4
    subplot(2,2,i);
    xlabel('wavelength (um)')
    ylabel(output_label)
    ylim([0,y_max*5/4])
end
subplot(2,2,1)
text(1.02,1.1,['Material--',Material],'FontSize',16,'units','normalized')


