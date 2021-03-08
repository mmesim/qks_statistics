function [Mcboot,Mcunc,avalboot,avalun,bvalboot,bvalun]=my_uncert(McCat,Nboot)
% Function to do bootstrap to find standard error for Mc, a, b
% and a mean Mc, a, and b-value

mag=McCat(:,10);
Ncat=length(McCat(:,10));

%Table with Mc, a value, b value [after bootstraping]
table=NaN*ones(Nboot,3);

%% Now do bootstrap Nboot times
for i=1:Nboot
%This is the Nth bootstrap sample
bstrp=randsample(mag,Ncat,true); %true stands for "with replacement"   

temp=[NaN*ones(Ncat,9) bstrp]; %Create a dummy catalog with NaNs

[~,table(i,1),table(i,2),table(i,3),~]=my_mc(temp);

end
% Get mean values and standartd deviation [standard error]
%Mc
Mcboot=mean(table(:,1));
Mcunc=std(table(:,1));
%a-value
avalboot=mean(table(:,2));
avalun=std(table(:,2));
%b-value
bvalboot=mean(table(:,3));
bvalun=std(table(:,3));
end