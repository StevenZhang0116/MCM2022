clear
load tokyo
ws = linspace(0,max(ww),55);
ss  = [];
Is = [];

for i = 1: length(ws)
    wi = ws(i);
    dist = abs(wi-ww);
    [~, I] = sort(dist);
    Is = [Is, I(1)];
end

Is = sort(Is);
ss = s(Is);
hs = h(Is);
ks = (hs(2:end)-hs(1:end-1))./(ss(2:end)-ss(1:end-1));