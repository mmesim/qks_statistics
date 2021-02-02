%Fit CDF to a catalog 
%KS test
clear ;clc ; close all

%% load catalog
load test.mat
load distributions.mat
alpha=0.05;
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

%non-zero elements
nonz=[a1' N'];
nonz=nonz(nonz(:,1)>0,:);

%% ------------------------------------------------------------
figure
%fit Distribution to cdf
[f,x]=ecdf(nonz(:,2),'frequency',freq);
ylgn=cdf(lgn,epd(:,1),'freq',freq);
ywbl=cdf(wbl,epd(:,1),'freq',freq);
ygm=cdf(gm,epd(:,1),'freq',freq);
yex=cdf(ex,epd(:,1),'freq',freq);

%% K-S test
%Goodness of Fit
%x=x(2:end);
f1=f(2:end);
f2=f(1:end-1);

%K-S test -->Manualy
diff1=[abs(f1-ylgn) abs(f1-ywbl) abs(f1-ygm) abs(f1-yex)];
diff2=[abs(f2-ylgn) abs(f2-ywbl) abs(f2-ygm) abs(f2-yex)];

diff=[diff1; diff2];

ks=(max(diff))';

n=length(f1);
%--------------------------------
%p-value  KS test
[ks_pval]=pval_kstest( n,ks,alpha );
% --------------------------------
%Critical value KS test
cv_ks=sqrt(-0.5*log(0.05/2))/sqrt(length(f1));

%% Plot
stairs(x,f,'-k','LineWidth',2)
hold on
semilogx(epd(:,1),ylgn,'m-','LineWidth',2)
semilogx(epd(:,1),ywbl,'g-','LineWidth',2)
semilogx(epd(:,1),ygm,'b-','LineWidth',2)
semilogx(epd(:,1),yex,'r-','LineWidth',2)
legend('Empirical','Lognormal','Weibull','Gamma','Exponential','Location','NorthWest')
hold off
xlabel('Interevent Time (days)')
ylabel('CDF')
set(gca,'xscale','log','FontSize',14,'FontName','Helvetica')

clear  a1 day diff diff1 diff2 epd f f1 f2  freq hr inter j mn month n N NBIN nonz  sec x X year yexp ygm ylgn ywbl

save cdf_distributions.mat