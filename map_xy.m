function map_xy(a)
%vectors to create a map
lat=a(:,7);
lon=a(:,8);

%M_map map
figure
%Projection and map boundaries
m_proj('mercator','longitudes',[min(lon)-0.5 max(lon)+0.5], ...
       'latitudes',[min(lat)-0.5 max(lat)+0.5],.5);
%high resolution coastline
m_gshhs_h('patch',[.5 .5 .5],'LineWidth',1.5);
%Misc properties [ grid, scale]
m_grid('box','on','tickstyle','dd','tickdir','out')
m_ruler([0.5 0.8],0.95,2,'ticklen',[.01],'fontsize',12,'tickdir','in')
hold on
%add seismicity
m_plot(lon,lat,'r.')

% saveas(f1,'map_xy.eps','eps')
% close(f1)

end