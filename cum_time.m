function cum_time(a)

%Convert to Decimal Years
time=decyear(a(:,1:6));
%Cumulative
N=(1:length(a(:,1)))';

figure
plot(time,N,'-','Linewidth',1.5)
xlim([floor(min(time)) max(time)]);
ylim([1 N(end,1)+5])
xlabel('Time [years]');
ylabel('Cumulative');
myticks=floor(min(time):5:max(time));

set(gca,'FontSize',15,'FontName','Helvetica','Xtick',myticks)

% saveas(f1,'cum_time.eps','eps')
% close(f1)
end