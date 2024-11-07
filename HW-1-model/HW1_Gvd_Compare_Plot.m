clc;
clear all;
close all;

% s = tf('s');

% Define the Power-Stage Parameters Here
Vin = 12;
D = 0.25;
L = 3e-6;
Le = L/(1-D)^2;
Rl = 200e-3;
Rc = 3e-3;
C = 300e-6;

% Gvd = (Vin*(Rl - D*Le*s)*(C*Rc*s + 1))/((D - 1)^2*(Rl + Le*s + C*Le*Rc*s^2 + C*Le*Rl*s^2 + C*Rc*Rl*s));
% Gvv =-(D*Rl*(C*Rc*s + 1))/((D - 1)*(Rl + Le*s + C*Le*Rc*s^2 + C*Le*Rl*s^2 + C*Rc*Rl*s));
% Zo  = (Le*Rl*s*(C*Rc*s + 1))/(Rl + Le*s + C*Le*Rc*s^2 + C*Le*Rl*s^2 + C*Rc*Rl*s);
% 
% bode(Gvd)



% Store the SIMPLIS Response in an Excel File and bring the data to MATLAB
% workspace with the help of "readmatrix" function
sim_data = readmatrix('BuckBoost_Gvd.xlsx','Sheet','Sheet1');
frequency = sim_data(:,1);
magnitude_sim = sim_data(:,2);
phase_sim = sim_data(:,3);

% Evalute Your Model at Frequencies Simulated in SIMPLIS Software
wout = 2*pi*frequency;
for j=1:length(wout)
     
     % Defintion of Complex Variable 's'
     s = 1i*wout(j);
     
     % Transfer Function in s-domain
     Gvd(j) = -(Vin*(Rl - D*Le*s)*(C*Rc*s + 1))/((D - 1)^2*(Rl + Le*s + C*Le*Rc*s^2 + C*Le*Rl*s^2 + C*Rc*Rl*s));

     % Bode Magnitude Calculation
     magnitude_model(j) = 20*log10(abs(Gvd(j)));
     
     % Phase Calculation
     phase_model(j) = 180*angle(Gvd(j))/pi;
end

%s = tf('s');
%Gvd1 = (Vin*(Rl - D*Le*s)*(C*Rc*s + 1))/((D - 1)^2*(Rl + Le*s + C*Le*Rc*s^2 + C*Le*Rl*s^2 + C*Rc*Rl*s));
%[magnitude_model,phase_model]=bode(-Gvd1,wout);
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

