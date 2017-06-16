%% Compute half width of contact rectangle b/w 2 parallel cylinders (Hrtz Cntct)
F = 2500;
rp = 0.29; % Poisson's Ratio
E = 205e9; % Young's modulus = 205 GPa
L = 4e-3; % in m Contact Length Obtained by measuring width wear on roller
R1 = 116.5e-3; % in m wheel radius
R2 = 506.23e-3; % in m roller radius
b = sqrt((4*F*2*(1-rp^2)/E)/(pi*L*(1/R1 + 1/R2)));
A = 2*b*L; % Area of contact rectangle
Pc = F/A; % Contact Pressure
mu = 0.6;
kC = 4*R1/(mu*b) % Carter's Creepage Coefficient
G = E/(1+rp);
P = G/((1-rp)*R1)
Fz = F/L;
a = sqrt(2*Fz/(pi*P))
fprintf('Semi width b (m) = %0.2d Contact Area (m^2) = %0.2d \n Contact Pressure (Pc) = %0.2d Pa\n',b,A,Pc);