clear
load tokyo
ws = linspace(0,max(ww),56);
ss  = [];

for i = 1: length(ws)
    wi = ws(i);
    dist = abs(wi-ww);
    [~, I] = sort(dist);
    twoS = s(I(1:2));
    smin = min(twoS);
    smax = max(twoS);
    twoW = ww(I(1:2));
    wmin = min(twoW);
    wmax = max(twoW);
%     wmin = ww(s==smin);
%     wmax = ww(s==smax);

    if abs(wmax-wmin) <1e-1
        si = (smax+smin)/2;
    else
        si = (smax - smin)*wi/(wmax-wmin);
    end
    ss = [ss, si];
end