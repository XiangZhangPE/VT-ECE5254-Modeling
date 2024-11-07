clc;close all;

%% v0/d
% syms s C Rc Rl Le D Vin
% 
% L = Le*(1-D)^2;
% Zl = Rl*(Rc+1/(s*C))/(Rl+Rc+1/(s*C));
% Vo = Vin*D/(1-D);
% IL = Vin*D/Rl/(1-D)^2;
% 
% Gd2vo = (Zl*s*Le/(Zl+s*Le))*(-IL+(1-D)*(Vin+Vo)/(s*L));
% 
% ans = simplify(Gd2vo)

%% v0/d flyback
% syms s C Rc Rl Le D Vin n
% 
% L = Le*(1-D)^2/n^2;
% Zl = Rl*(Rc+1/(s*C))/(Rl+Rc+1/(s*C));
% Vo = Vin*D/(1-D);
% IL = Vin*D*n^2/Rl/(1-D)^2;
% 
% Gd2vo = (Zl*s*Le/(Zl+s*Le))*(-IL/n+n*(Vin+Vo/n)/(1-D)/(s*Le));
% 
% ans = simplify(Gd2vo)

%% vo/vin
syms s C Rc Rl Le D Vin

L = Le*(1-D)^2;
Zl = Rl*(Rc+1/(s*C))/(Rl+Rc+1/(s*C));
Iin = D/((1-D)*s*Le);
Gvo2vin = (Zl*s*Le/(Zl+s*Le))*Iin;

% Vo = Vin*D/(1-D);
% IL = Vin*D/Rl/(1-D)^2;

ans = simplify(Gvo2vin)

%% v0/io
% syms s C Rc Rl L D
% 
% L = Le*(1-D)^2;
% Zl = Rl*(Rc+1/(s*C))/(Rl+Rc+1/(s*C));
% Zo = (Zl*s*Le/(Zl+s*Le));
% 
% ans = simplify(Zo)

