load tokyo
plot(s, ww,'LineWidth',1)
hold on 
localmax = islocalmax(ww);
localmin = islocalmin(ww);
scatter(s(localmax),ww(localmax),'c*')
scatter(s(localmin),ww(localmin),'r*')
xlabel('s(m)')
ylabel('w/mg(KJ/N)')
legend('s-ww','local max','local min')
saveas(gca, 'w-s.eps','epsc')