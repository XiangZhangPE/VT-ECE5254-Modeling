clc;close all;clear all;

%% type III compensator value calculator (simplified) read Dr.LiQiang PPT C1>>C3

% % case 2 fc=1khz
% R1 = 100e3;
% wi = 530;
% wz1 = 5.39e4;
% wz2 = 1.27e5;
% wp1 = 1.02e6;
% wp2 = 2.61e6;

% % case 3 fc=200khz
% R1 = 100e3;
% wi = 80000;
% wz1 = 3.06e4;
% wz2 = 1.59e5;
% wp1 = 1.02e6;
% wp2 = 3.42e6;

% case 4 fc=300khz
R1 = 40e3;
wi = 60000;
wz1 = 1.66e4;
wz2 = 1.3e5;
wp1 = 1.02e6;
wp2 = 2.95e6;

C1 = 1 / (wi * R1);
R2 = (R1 * wi) / wz1;
C2 = 1 / (wz2 * R1);
R3 = (R1 * wz2) / wp1;
C3 = wz1 / (R1 * wi * wp2);

% C1>>C3, R1>>R3

fprintf('R1 = %.2f k\n',R1/10^3)
fprintf('R2 = %.2f k\n',R2/10^3)
fprintf('R3 = %.2f k\n',R3/10^3)
fprintf('C1 = %.2f pF\n',C1*10^12)
fprintf('C2 = %.2f pF\n',C2*10^12)
fprintf('C3 = %.2f pF\n',C3*10^12)

s = tf('s');
Gcomp = -wi*(1+s/wz1)*(1+s/wz2)/(s*(1+s/wp1)*(1+s/wp2))

