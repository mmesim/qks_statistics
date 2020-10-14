function a=get_events(r,newcat,nodes)
% Find events in a given radius (in km)
% around a grid point (node)

%% Define Lat Lon and reference point
lat=newcat(:,7); lon=newcat(:,8);

rlat=nodes(1,1); rlon=nodes(1,2);

%% Get distance
dis=deg2km(distance(lat,lon,rlat,rlon)); %use of distance function

%Now find events that are at a given distance (r) from the grid point
index=dis<=r;

%return new catalog with events around r km from the grid point
a=newcat(index>0,:);


end