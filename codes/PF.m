function P = PF(F)
% P0 = 1e3;
P0 = 800;
% P1 = 200;
P1 = 300;
P = [];

P = [P, (1-F)*(P0-P1)+P1];
end