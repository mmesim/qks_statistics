function [McCat,Mc,aval,bval,bvalerr]=my_mc(a)
%function to simply compute Mc
% using the aximum curvature method
%binning of 0.1
%--------------------------------------------------------------------------
mag=a(:,10);

%bin magnitudes and find obs in each bin
M=min(mag):0.1:max(mag);
[Nobs,~]=hist(mag,M);

%Create an array and find maximum Nobs and M
all=[M' Nobs'];
[~,index]=max(all(:,2));

%Mc [add 0.2 (correction)]
Mc=all(index,1)+0.2;
McCat=a(a(:,10)>=Mc-0.0499,:);

% a and b values [MLE Aki, 1965]
avg_mag=mean(McCat(:,10));
Ncat=length(McCat(:,1));

%b-value
bval=log10(exp(1))/(avg_mag-(Mc-0.05));
%Shi and Bolt, 1982
bvalerr=(2.30*bval.^2)*(sqrt(sum((McCat(:,10)-avg_mag).^2)/(Ncat*(Ncat-1))));

%a value
aval=log10(Ncat)+ (bval*Mc);

end