clc;close all;

%% vo/io
syms s C Rl L D M vo F

Re = (2*L*F)/D^2;
vac = vo/(M^2*Re)/(s*L*Re/(s*L+Re)-2*M/Rl+1/(M^2*Re));
I1 = vac/(s*L*Re/(s*L+Re));
I2 = vo/(Rl/(Rl*C*s+1));

Zo = vo/(I1+I2);

ans = simplify(Zo)

