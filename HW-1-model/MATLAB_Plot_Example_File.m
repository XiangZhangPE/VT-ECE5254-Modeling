clc;
clear all;
close all;

% Define the Power-Stage Parameters Here
Ls = 600e-9;
Rco = 6e-3;
Co = 560e-6;
RL = 100e-3;

% Store the SIMPLIS Response in an Excel File and bring the data to MATLAB
% workspace with the help of "readmatrix" function
sim_data = readmatrix('Buck_Output_Impedance_Example.xlsx','Sheet','Sheet1');
frequency = sim_data(:,1);
magnitude_sim = sim_data(:,2);
phase_sim = sim_data(:,3);

% Evalute Your Model at Frequencies Simulated in SIMPLIS Software
wout = 2*pi*frequency;
for j=1:length(wout)
     
     % Defintion of Complex Variable 's'
     s = 1i*wout(j);
     
     % Transfer Function in s-domain
     Zo(j) = (s*Ls*(1+s*Rco*Co))/(s*(Ls/RL + Rco*Co) + s^2*Ls*(1 + Rco/RL)*Co + 1);

     % Bode Magnitude Calculation
     magnitude_model(j) = 20*log10(abs(Zo(j)));
     
     % Phase Calculation
     phase_model(j) = 180*angle(Zo(j))/pi;
end

% Magnitude Plot
subplot(2,1,1)
semilogx(frequency,squeeze(magnitude_model),'color','blue','LineWidth',2,'DisplayName','Model');
hold on
semilogx(frequency,magnitude_sim,':r','LineWidth',4,'DisplayName','SIMPLIS');
ylabel('Magnitude [dB]');
xlabel('Frequency [Hz]');
axis tight
grid on
set(gca, 'fontsize',12);
legend('Location','best')

% Phase Plot
subplot(2,1,2)
semilogx(frequency,squeeze(phase_model),'color','blue','LineWidth',2,'DisplayName','Model');
hold on
semilogx(frequency,phase_sim,':r','LineWidth',4,'DisplayName','SIMPLIS');
ylabel('Phase [deg]');
xlabel('Frequency [Hz]');
axis tight
grid on
set(gca, 'fontsize',12);
legend('Location','best')

