%Fit PDF to a catalog
%procedure same as Corral, 2006
clear; clc ; close all

%% load catalog
load test.mat

% Set columns for origin time 
% Default is Zmap format
year=3; month=4; day=5; 
hr=8; mn=9; sec=10;

%number of bins
NBIN=50;

%% Interevent times
%Calculate time
X=datenum(fix(a(:,year)),a(:,month),a(:,day),a(:,hr),a(:,mn),a(:,sec));

%interevent time
inter=diff(X);

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

%% fit Distribution to pdf
%Lognormal
lgn=fitdist(epd(:,1),'lognormal','freq',freq);
ylgn_pdf=pdf(lgn,epd(:,1));
%confidence Intervals for parameters
[algn, cilgn]=lognfit(epd(:,1),0.05,zeros(length(freq),1),freq);

%Weibull
wbl=fitdist(epd(:,1),'wbl','freq',freq);
ywbl_pdf=pdf(wbl,epd(:,1));
%%confidence Intervals for parameters
[awbl, ciwbl]=wblfit(epd(:,1),0.05,zeros(length(freq),1),freq);

%Gamma
gm=fitdist(epd(:,1),'gamma','freq',freq);
ygm_pdf=pdf(gm,epd(:,1));
%%confidence Intervals for parameters
[agm, cigm]=gamfit(epd(:,1),0.05,zeros(length(freq),1),freq);

%Exponential
ex=fitdist(epd(:,1),'exponential','freq',freq);
yexp_pdf=pdf(ex,epd(:,1));
%confidence Intervals for parameters
[aex, ciex]=expfit(epd(:,1),0.05,zeros(length(freq),1),freq);

%% calculate aic bic
Nobs=length(epd(:,1));
nparam=[lgn.NumParams; wbl.NumParams; gm.NumParams; ex.NumParams];

logL=[lgn.NLogL;wbl.NLogL; gm.NLogL; ex.NLogL];

[aic,bic]=aicbic(-logL,nparam,Nobs);


%% plot
loglog(epd(:,1),epd(:,2),'ko','MarkerSize',8) %empirical
hold on
loglog(epd(:,1),ylgn_pdf,'m-','LineWidth',2) %lognormal
loglog(epd(:,1),ywbl_pdf,'g-','LineWidth',2) %weibul
loglog(epd(:,1),ygm_pdf,'b-','LineWidth',2) %gamma
loglog(epd(:,1),yexp_pdf,'r-','LineWidth',2); %Exponetial

xlabel('Interevent Time (days)')
ylabel('Probability density')
ylim([10^(-4) 1000])
legend('Data','Lognormal','Weibull','Gamma','Exponential','Location','NorthEast')
set(gca,'FontName','Helvetica','FontSize',14)
hold off

clear  a1 a2 b bin day dens freq hr inter j mn month n N NBIN Nobs nparam sec X year yexp_pdf ygm_pdf ylgn_pdf ywbl_pdf
save distributions.mat 