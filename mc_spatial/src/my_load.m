function newcat=my_load(filename,stime,etime)
% Function to load catalog and 
%keep events for a given period

a=cell2mat(struct2cell(load(filename)));

newcat=a(a(:,1)>=stime & a(:,1)<=etime,:);

end
