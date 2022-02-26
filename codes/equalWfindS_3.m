clear
load tokyo
w = 0.04*s+h;
ww = w./1e3;
ws = linspace(0,max(ww),50);
ss = interp1(ww,s,ws,'linear');
plot(s,ww)
hold on
scatter(ss,ws)
% for i = 1: length(ws)
%     wi = ws(i);
%     dist = abs(wi-ww);
%     [~, I] = sort(dist);
%     twoS = s(I(1:2));
%     smin = min(twoS);
%     smax = max(twoS);
%     twoW = ww(I(1:2));
%     wmin = min(twoW);
%     wmax = max(twoW);
% %     wmin = ww(s==smin);
% %     wmax = ww(s==smax);
% 
%     if abs(wmax-wmin) <1e-1
%         si = (smax+smin)/2;
%     else
%         si = (smax - smin)*wi/(wmax-wmin);
%     end
%     ss = [ss, si];
% end