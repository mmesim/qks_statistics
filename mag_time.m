function  mag_time(a)

%Convert to Decimal Years
time=decyear(a(:,1:6));
%Magnitude
mag=a(:,10);

f1=figure;
axes('Position',[0.1 0.2 0.8 0.6])
stem(time,mag,'LineStyle','None')
xlim([floor(min(time)) max(time)]);
ylim([min(mag) max(mag)])
xlabel('Time [years]');
ylabel('Magnitude');
myticks=floor(min(time):5:max(time));

set(gca,'FontSize',15,'FontName','Helvetica','Xtick',myticks)

% saveas(f1,'cum_time.eps','eps')
% close(f1)

end