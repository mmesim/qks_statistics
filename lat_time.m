function  lat_time(a)

%Convert to Decimal Years
time=decyear(a(:,1:6));
%Latitude
lat=a(:,7);

f1=figure;
plot(time,lat,'.')
xlim([floor(min(time)) max(time)]);
ylim([min(lat) max(lat)])
xlabel('Time [years]');
ylabel('Latitude');
myticks=floor(min(time):5:max(time));

set(gca,'FontSize',15,'FontName','Helvetica','Xtick',myticks)

saveas(f1,'lat_time.eps','eps')
close(f1)
end