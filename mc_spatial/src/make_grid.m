function nodes=make_grid(newcat,x,y)
%Function to create grid 

% Find minimum and maximum lat-lon from the catalog
lat1=round(min(newcat(:,8)),1);
lat2=round(max(newcat(:,8)),1);
%Longitude
lon1=round(min(newcat(:,7)),1);
lon2=round(max(newcat(:,7)),1);

%Grid points
x1=lon1:x:lon2;
x2=lat1:y:lat2;

%Get grid
[X1,X2]=ndgrid(x1,x2);
nodes=[X1(:) X2(:)];


 

end