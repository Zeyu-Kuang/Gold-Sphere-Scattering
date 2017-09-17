% Optimization the parameters for pHd using non-linear fitting 
% same as pHd_fitting_1_par, but it plots two figures (pH0, pH7)

%% creating a fitting model for the pHd particles

% par(1) thickness of the coating
% x: wavelength

m1 = 1.59;  % core refractive index
m2 = 1.508;
a = 202;
nor = 1;
modelfun = @(par, x)My_plot_Q_over_lambda(m1, m2, a, par(1), x, nor);  

for i = 1:2
    %% reading data (pH=7 normalized spectrum)
    pH = i*7-7;
    filename = ['pHd_scs_pH',num2str(pH),'.csv'];
    Wave_Spec = dlmread(filename,' ',1,0);
    Wave_Spec = Wave_Spec(1:400,:);
    wavelength = Wave_Spec(:,1);
    spectrum = Wave_Spec(:,2);

    %% fitting 
    beta0 = [9.5273];  % initializing pars [coating thickness]
    [beta,R,~,~,~,~] = nlinfit(wavelength,spectrum,modelfun,beta0);

    %% plotting
    c = beta(1);

    Q = My_plot_Q_over_lambda(m1,m2,a,c,wavelength,nor);
    subplot(2,2,i)
    plot(wavelength,Q,'LineWidth',2)
    ylabel('Normalized SCS', 'FontSize',14)
    xlabel('Wavelength (nm)','FontSize',14)
    title(['pH',filename(11)])
    hold on
    plot(wavelength, spectrum,'LineWidth',2)
    subplot(2,2,i+2)
    plot(wavelength,R,'LineWidth',2)
    ylabel('Residual','FontSize',14)
    xlabel('Wavelength (nm)','FontSize',14)
    ylim([-0.4,0.4])

    fprintf(['m1: ',num2str(m1),'\nm2: ',num2str(m2),'\nradius: ',num2str(a),'nm','\nthickness: ',num2str(c),'nm\n'])
end
