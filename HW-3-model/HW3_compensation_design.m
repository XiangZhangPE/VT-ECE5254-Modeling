clc;close all;

%% calculate transferfunction
syms Vin Rc Rl Ro C L s

Zl = Ro*(s*C*Rc+1)/(1+s*C*Rc+s*C*Ro);
Gvd = Vin*Zl/(Rl+s*L+Zl);
Zo = (Rl+s*L)*Zl/(Rl+s*L+Zl);

ans1 = simplify(Gvd);
ans2 = simplify(Zo);

%% parameter assignment
Vin = 12;
L = 150e-9;
C = 1e-3;
Ro = 0.2;
Rl = 2e-3;
Rc = 1e-3;

%% system verification
s = tf('s');
Gvd_open = (Ro*Vin*(C*Rc*s + 1))/((C*Rc*s + C*Ro*s + 1)*(Rl + L*s) + (Ro*(C*Rc*s + 1)))
Zo_open = (Ro*(C*Rc*s + 1)*(Rl + L*s))/((C*Rc*s + C*Ro*s + 1)*(Rl + L*s) + (Ro*(C*Rc*s + 1)))

% pole(Gvd_open)
% zero(Gvd_open)
% % % plotoptions = pzoptions;
% % % plotoptions.Grid = 'on';
% % % plotoptions.FreqUnit = 'Hz';
% % % pzplot(Gvd_open,plotoptions)
% figure
% pzmap(Gvd_open);
% grid on;
% 
% figure
% bode(Gvd_open); hold on;
% grid on;
% 
% m_fc = 1;
% [mag,phase,wout] = bode(Gvd_open);
% phase_m = interp1( squeeze(mag), squeeze(phase), m_fc)
% w_m     = interp1( squeeze(mag), wout, m_fc)/(2*pi)

%% control system design using matlab apps
controlSystemDesigner(Gvd_open);



