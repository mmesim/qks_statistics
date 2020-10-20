function newcat=my_load(filename,stime,etime)
% Function to load catalog and 
%keep events for a given period

%Load variable from mat file
a=cell2mat(struct2cell(load(filename)));

%Keep events at given time
newcat=a(a(:,1)>=stime & a(:,1)<=etime,:);

%Remove earthquakes with no magnitudes
newcat=newcat(newcat(:,10)>-9.99,:);

%Round magnitudes to first decimal
newcat(:,10)=round(newcat(:,10),1);

end
