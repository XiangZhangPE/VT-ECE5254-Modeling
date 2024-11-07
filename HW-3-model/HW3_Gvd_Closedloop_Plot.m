clc;
clear all;
close all;

% s = tf('s');

% Define the Power-Stage Parameters Here

Vin = 12;
D = 0.167;
L = 150e-9;
C = 1e-3;
Ro = 0.2;
Rl = 2e-3;
Rc = 1e-3;

wi = 12000;
wz1 = 1.4e4;
wz2 = 1.44e5;
wp1 = 1.02e6;
wp2 = 2.73e6;

% Gcomp = -wi*(1+s/wz1)*(1+s/wz2)/(s*(1+s/wp1)*(1+s/wp2));
% Gvd = (Ro*Vin*(C*Rc*s + 1))/((C*Rc*s + C*Ro*s + 1)*(Rl + L*s) + (Ro*(C*Rc*s + 1)))
% Zo  = (Ro*(C*Rc*s + 1)*(Rl + L*s))/((C*Rc*s + C*Ro*s + 1)*(Rl + L*s) + (Ro*(C*Rc*s + 1)))

% Store the SIMPLIS Response in an Excel File and bring the data to MATLAB
% workspace with the help of "readmatrix" function
sim_data = readmatrix('Buck_Closed_Gvd_80kHz.xlsx','Sheet','Sheet1');
frequency = sim_data(:,1);
magnitude_sim = sim_data(:,3);
phase_sim = sim_data(:,5);

% Evalute Your Model at Frequencies Simulated in SIMPLIS Software
wout = 2*pi*frequency;
for j=1:length(wout)
     
     % Defintion of Complex Variable 's'
     s = 1i*wout(j);
     
     % Transfer Function in s-domain
     Gvd(j) = (Ro*Vin*(C*Rc*s + 1))/((C*Rc*s + C*Ro*s + 1)*(Rl + L*s) + (Ro*(C*Rc*s + 1)));
     Gcomp(j) = wi*(1+s/wz1)*(1+s/wz2)/(s*(1+s/wp1)*(1+s/wp2));
     T(j) = Gvd(j)*Gcomp(j);
     

     % Bode Magnitude Calculation
     magnitude_model(j) = 20*log10(abs(Gvd(j)));
     magnitude_model_closed(j) = 20*log10(abs(T(j)));
     
     % Phase Calculation
     phase_model(j) = 180*angle(Gvd(j))/pi;
     phase_model_closed(j) = 180*angle(T(j))/pi;
     
end

%s = tf('s');
%Gvd1 = (Vin*(Rl - D*Le*s)*(C*Rc*s + 1))/((D - 1)^2*(Rl + Le*s + C*Le*Rc*s^2 + C*Le*Rl*s^2 + C*Rc*Rl*s));
%[magnitude_model,phase_model]=bode(-Gvd1,wout);
% Magnitude Plot

subplot(2,1,1)
semilogx(frequency,squeeze(magnitude_model),'color','blue','LineWidth',2,'DisplayName','Gvd(s)-Model');
hold on
semilogx(frequency,squeeze(magnitude_model_closed),'color','magenta','LineWidth',2,'DisplayName','T(s)-Model');
hold on

semilogx(frequency,magnitude_sim,':r','LineWidth',4,'DisplayName','T(s)-SIMPLIS');
ylabel('Magnitude [dB]');
xlabel('Frequency [Hz]');
axis tight
grid on
set(gca, 'fontsize',12);
legend('Location','best')

% Phase Plot
subplot(2,1,2)
semilogx(frequency,squeeze(phase_model),'color','blue','LineWidth',2,'DisplayName','Gvd(s)');
hold on
semilogx(frequency,squeeze(phase_model_closed),'color','magenta','LineWidth',2,'DisplayName','T(s)-Model');
hold on

semilogx(frequency,phase_sim,':r','LineWidth',4,'DisplayName','T(s)-SIMPLIS');
ylabel('Phase [deg]');
xlabel('Frequency [Hz]');
axis tight
grid on
set(gca, 'fontsize',12);
legend('Location','best')

