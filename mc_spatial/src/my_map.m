function my_map(lat, lon, val,newcat,mystring)
%Function to create a colormap
%Using M_map 

%Projection and map boundaries
m_proj('mercator','longitudes',[min(lon)-0.25 max(lon)+0.25], ...
       'latitudes',[min(lat)-0.25 max(lat)+0.25],.5);
   hold on

m_scatter(lon,lat,200,val,'s','filled');
colormap(jet);
colorbar
%--------------------------------------------------------------------------
%high resolution coastline
m_gshhs_h('patch',[.5 .5 .5],'LineWidth',1.5);
%Misc properties [ grid, scale]
m_grid('box','on','tickstyle','dd','tickdir','out')
m_ruler([0.5 0.8],0.95,2,'ticklen',[.01],'fontsize',12,'tickdir','in')
hold on
%hold on
m_plot(newcat(:,8),newcat(:,7),'.','MarkerEdgeColor','k','MarkerSize',1)
title(mystring)


end
