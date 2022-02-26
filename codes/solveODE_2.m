% solve ode 
clear
load tokyo
load F
Ps = PF(F_norm);
mu_roll = 0.04;
g = 9.8;
m = 90;
rho = 1e-3;
Cd = 0.6;
A = 0.15;
N = length(Ps);
vs = zeros(1,N);
m = 80;
% v_w = zeros(1,N);
v_w  = 290*v_w;
dw = 0.5e3; 
vs(1) = 10;

for i = 1:N
    P_drag = @(v) v.*rho*Cd*A.*(v+v_w(i)).^2/2;
    f = @(v) Ps(i)/(m*v)-rho*Cd*A*(v+v_w(i))^2/(2*m)-g*ks(i)-mu_roll*g;
    if i<N
        k1 = f(vs(i))/(Ps(i)-P_drag(vs(i)));
        k2 = f(vs(i)+k1*dw/2)/(Ps(i)-P_drag(vs(i)+k1*dw/2));
        k3 = f(vs(i)+k2*dw/2)/(Ps(i)-P_drag(vs(i)+k2*dw/2));
        vs(i+1) = vs(i)+dw*f(vs(i)+dw*k3)/(Ps(i)-P_drag(vs(i)+dw*k3));
    end
end
% plot(ss(2:end),vs)