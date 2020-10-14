function table=my_mc_spatial(nodes,newcat,r,N,Nboot)
%Function to calculate Mc and b values for a grid of nodes
%It follows the structure of bvalgrid.m in Zmap v6.?
%--------------------------------------------------------------------------
%Table to save all the output parameters
%Assign NaN to (i) pre-allocaet memory, 
%and (ii) not to mess up with other values
%Format:
%Mc Mc-boot Mc-unc lon lat b-val b-val-err b-val-boot b-val-unc a-val a-valboot a-val-unc Mmax Nevents
table=NaN*(ones(length(nodes),14));

%Start loop for each node

parfor i=1:length(nodes(:,1))
%Get events in given radius
temp=get_events(r,newcat,nodes(i,:));   

%--------------------------------------------------------------------------
%First if statement for N of events
%Check if N of catalog is above given N
if length(temp(:,1))>=N
 %do Mc [Maximum Curvature]
[McCat,Mc,aval,bval,bvalerr]=my_mc(temp);

%--------------------------------------------------------------------------
% Second  if statement [if N of events are above N after applying Mc]
 if length(McCat(:,1))>=N
      %Calc uncertainties with bootstrap
      [Mcboot,Mcunc,avalboot,avalun,bvalboot,bvalun]=my_uncert(McCat,Nboot);
      
      %save to table
      table(i,:)=[Mc Mcboot Mcunc nodes(i,2) nodes(i,1) bval bvalerr bvalboot bvalun aval avalboot avalun max(McCat(:,10))  length(McCat(:,1))]; 
 end %end of second if

end %end of first if
end %end of for loop for each grid point



end