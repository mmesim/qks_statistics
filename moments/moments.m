function [tmax,S,K]=moments(a,index)
%--------------------------------------------------------------------------
%calculate tmax, skewness, and kurtosis of Moment release
%Input: a [Array, earthquake catalog]
%format YYYY MM DD HR MIN SEC.MSEC LAT LON DEPTH MAG 
%It doesn't matter if there are more columns
%Here we work with the first 10
%Note: Remove all strings
%--------------------------------------------------------------------------

%% keep only the first 10 columns - just in case 
a=a(:,1:10);

%% convert time  
X=datenum(a(:,1),a(:,2),a(:,3),a(:,4),a(:,5),a(:,6));
t1=(X-X(1,1));
t=t1/mean(t1);
%% define magnitude and copnvert to Mo (Kanamori,1977) (dyn*cm)
ML=a(:,10);
Mo=10.^(1.5*ML+16.1);

%% Find tmax (the time of largest magnitude)
ALL=[a t Mo t1];
b=ALL(ALL(:,10)==max(ML),:);
tmax=b(1,11);

%% calculate cntroid time T
T=(sum(Mo.*t))/(sum(Mo));

%% normalized moment magnitude 
mo=Mo/(sum(Mo));

%% Third central moment
m3=sum(((t-T).^3).*mo);

%% Forth central moment
m4=sum(((t-T).^4).*mo);
%% Standard deviation
s=sqrt(sum(((t-T).^2).*mo));

%% Skewness
S=m3/(s^3);
%% Kurtosis
K=m4/(s^4);

%% plot Moment with time
filename=sprintf('Cluster_%02d',index);
filename2=sprintf('Cluster:%02d',index);
figure
semilogy(ALL(:,11),ALL(:,12),'ko')
set(gca,'FontName','Helvetica','FontSize',14,'XMinorTick','on','YMinorTick','on')
xlabel('Time in days')
ylabel('Moment Release (dyn*cm)')
title(filename2)
print(filename,'-dpng','-r300')
close all
end %end of function 
 
