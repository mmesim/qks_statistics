%Data from Florina South Cluster
%procedure same as Corral, 2006
clear
clc
load non_complete
clearvars -except a

Mc=1.3;

south=a(a(:,7)<=40.7440 & a(:,10)>=Mc,:);

%Calculate time
X=juliandate(south(:,1),south(:,2),south(:,3),south(:,4),south(:,5),south(:,6));
time=(X-X(1,1));  

rate=length(X)/max(time);
%number of bins
NBIN=50;

%calculate interevent time
for i=1:length(X)-1
    inter(i)=X(i+1)-X(i);
end

%normalised interevent times
%ninter=inter*rate;

figure
%counting bin
n=logspace(-4,2,NBIN+1);
N=n(1:end-1);

%find events in each bin
a1=hist(inter,N);
freq=a1';
freq=freq(freq(:,1)>0,:);


%Probability
a2=a1./length(inter);

%find bin width 
for j=1:length(n)-1
bin(j)=n(j+1)-n(j);
end

%Probability Density
b=a2./bin;

%non zero elements ---epd(empirical)
dens=[N' b'];
epd=dens(dens(:,2)>0,:);

%plot
loglog(epd(:,1),epd(:,2),'ko','LineWidth',1.5)
axis square
xlabel('Interevent Time (days)','FontSize',12)
ylabel('Probability density','FontSize',12)

hold on

clear Mc NBIN i j rate a N X 

%fit Distribution to pdf
%Lognormal
lgn=fitdist(epd(:,1),'lognormal','freq',freq);
ynew=pdf(lgn,epd(:,1));
loglog(epd(:,1),ynew,'m-','LineWidth',2)
%confidence Intervals for parameters
%[algn, cilgn]=lognfit(epd(:,1),0.05,zeros(length(freq),1),freq);
clear ynew


%Weibull
wbl=fitdist(epd(:,1),'wbl','freq',freq);
ynew=pdf(wbl,epd(:,1));
loglog(epd(:,1),ynew,'g-','LineWidth',2)
%%confidence Intervals for parameters
%[awbl, ciwbl]=wblfit(epd(:,1),0.05,zeros(length(freq),1),freq);
clear ynew

%Gamma
gm=fitdist(epd(:,1),'gamma','freq',freq);
ynew=pdf(gm,epd(:,1));
loglog(epd(:,1),ynew,'b-','LineWidth',2)
%%confidence Intervals for parameters
%[agm, cigm]=gamfit(epd(:,1),0.05,zeros(length(freq),1),freq);
clear ynew

%Pareto
%gpar=fitdist(epd(:,1),'Generalized Pareto','freq',freq);
%ynew=pdf(gpar,epd(:,1));
%loglog(epd(:,1),ynew,'y-','LineWidth',2)
%%confidence Intervals for parameters
%[agpar, cigpar]=gpfit(epd(:,1));
%clear ynew

%Exponential
ex=fitdist(epd(:,1),'exponential','freq',freq);
ynew=pdf(ex,epd(:,1));
loglog(epd(:,1),ynew,'r-','LineWidth',2)
%confidence Intervals for parameters
%[aex, ciex]=expfit(epd(:,1),0.05,zeros(length(freq),1),freq);
clear ynew
ylim([10^(-4) 1000])
legend('Data','Lognormal','Weibull','Gamma','Exponential','Location','NorthEast')


%calculate aic bic
Nobs=length(epd(:,1));
nparam=[lgn.NumParams; wbl.NumParams; gm.NumParams; ex.NumParams];

logL=[lgn.NLogL;wbl.NLogL; gm.NLogL; ex.NLogL];

[aic,bic]=aicbic(-logL,nparam,Nobs);

clear south time nparam n inter dens bin b a2 a1 Nobs logL
%fitting tests
%PowerLaw
% P=polyfit(log10(npd(:,1)),log10(npd(:,2)),1)
% Y=polyval(P,log10(npd(:,1)));
% plot(npd(:,1),10.^Y,'m-')

save distributions.mat