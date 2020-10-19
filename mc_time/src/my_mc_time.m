function table=my_mc_time(newcat,Nwin,Nstep,N,Nboot)
%Function to calculate Mc with time
%given a window of events, with increment one
%--------------------------------------------------------------------------
%Table to save all the output parameters
%Assign NaN to (i) pre-allocate memory, 
%and (ii) not to mess up with other values
%Format:
%Mc Mc-boot Mc-unc  b-val b-val-err b-val-boot b-val-unc a-val a-valboot
%a-val-unc Mmax Nevents time
%--------------------------------------------------------------------------
Twin=1:Nstep:length(newcat(:,1))-Nwin; %this is the number of samples
table=NaN*(ones(length(Twin),12)); %here we'll save the output 

%Start loop for each time window

parfor i=1:length(Twin)
%Keep events in the window
temp=newcat(Twin(i):Twin(i)+Nwin,:);
time(i,1)=decyear(temp(end,1:6)); %Assign time - last event in sub-catalog
%--------------------------------------------------------------------------
%First if statement for N of events
%Check if N of catalog is above given N
 if length(temp(:,1))>=N
% do Mc [Maximum Curvature]
[McCat,Mc,aval,bval,bvalerr]=my_mc(temp);
% 
%--------------------------------------------------------------------------
% Second  if statement [if N of events are above N after applying Mc]
 if length(McCat(:,1))>=N
      %Calc uncertainties with bootstrap
      [Mcboot,Mcunc,avalboot,avalun,bvalboot,bvalun]=my_uncert(McCat,Nboot);
      
      %save to table
      table(i,:)=[Mc Mcboot Mcunc bval bvalerr bvalboot bvalun aval avalboot avalun max(McCat(:,10))  length(McCat(:,1))]; 
 end %end of second if

 end %end of first if
 end %end of for loop for each sample

table=[table time];


end