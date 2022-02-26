% solve ode 
clear
load tokyo
load F
Ps = PF(F_norm);
mu_roll = 0.04;  % 1
g = 9.8;          % m/s^2
m = 80;           %kg
rho = 1e-3;
Cd = 0.6;       
A = 0.36;         % m^2
N = length(Ps);
vs = zeros(1,N);
m = 80;
v_w = zeros(1,N);
dw = 0.5e3;         % J
vs(1) = 10;

for i = 1:N
    P_drag = @(v) v.*rho*Cd*A.*(v+v_w(i)).^2/2;
    f = @(v) Ps(i)/(m*v)-rho*Cd*A*(v+v_w(i))^2/(2*m)-g*ks(i)-mu_roll*g;
    if i<N
        vs(i+1) = vs(i)+dw*f(vs(i))/(Ps(i)-P_drag(vs(i)));
    end
end
