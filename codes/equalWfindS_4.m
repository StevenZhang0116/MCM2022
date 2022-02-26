clear
load tokyo
w = 0.04*s+h;
ww = w./1e3;
[s, Inx] = unique(s);
ww = ww(Inx);
h = h(Inx);
ww = interp1(s,ww,linspace(0,max(s),1e4),'linear');
h = interp1(s,h,linspace(0,max(s),1e4),'linear');
s = linspace(0,max(s),1e4);
ws = linspace(0,max(ww),50);
ss  = [];
Is = [];

for i = 1: length(ws)
    wi = ws(i);
    dist = abs(wi-ww);
    [~, I] = sort(dist);
    indx = I(1:5); % minimum elements indices
    [~,j] = min(s(indx)); % mimimum s, j mimimum s in the indx list
    ii = indx(j);
    Is = [Is, ii];
end

% Is = sort(Is);
ss = s(Is);
hs = h(Is);
ks = (hs(2:end)-hs(1:end-1))./(ss(2:end)-ss(1:end-1));

plot(s,ww,'Linewidth',1)
hold on
scatter(ss,ws)
xlabel('s(m)')
ylabel('w/mg(KJ/N)')
hold off
% saveas(gca,'ss-ws.eps','epsc')
% figure
% plot(s,h,'Linewidth',1)
% hold on
% scatter(ss,hs)
% xlabel('s(m)')
% ylabel('h(m)')
% saveas(gca,'ss-hs.eps','epsc')
