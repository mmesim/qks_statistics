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


alpha=0.05;
rate=length(X)/max(time);
%number of bins
NBIN=50;

%calculate interevent time
for i=1:length(X)-1
    inter(i)=X(i+1)-X(i);
end

%normalised interevent times
%ninter=inter*rate;

%counting bin
n=logspace(-4,2,NBIN+1);
N=n(1:end-1);

%find events in each bin
a1=hist(inter,N);

%non-zero elements
nonz=[a1' N'];
nonz=nonz(nonz(:,1)>0,:);

%CDF --->Manually
a2=nonz(:,1)./length(inter); %Probability
%Cumulative
ca2=cumsum(a2);

figure
%stairs(nonz(:,2),ca2,'-m','LineWidth',2)
%semilogx(nonz(:,2),ca2,'-k','LineWidth',2)
%hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load distributions.mat

%fit Distribution to cdf
[f,x]=ecdf(nonz(:,2),'frequency',freq);
stairs(x,f,'-k','LineWidth',2)
axis square
set(gca,'xscale','log')
xlabel('Interevent Time (days)','FontSize',12)
ylabel('CDF','FontSize',12)
hold on

ylgn=cdf(lgn,epd(:,1),'freq',freq);
ywbl=cdf(wbl,epd(:,1),'freq',freq);
ygm=cdf(gm,epd(:,1),'freq',freq);
%ygpar=cdf(gpar,epd(:,1),'freq',freq);
yex=cdf(ex,epd(:,1),'freq',freq);

%plot
semilogx(epd(:,1),ylgn,'m-','LineWidth',2)
semilogx(epd(:,1),ywbl,'g-','LineWidth',2)
semilogx(epd(:,1),ygm,'b-','LineWidth',2)
%semilogx(epd(:,1),ygpar,'y-','LineWidth',2)
semilogx(epd(:,1),yex,'r-','LineWidth',2)
%legend('Empirical','Lognormal','Weibull','Gamma','Gen. Pareto','Exponential','Location','NorthWest')
legend('Empirical','Lognormal','Weibull','Gamma','Exponential','Location','NorthWest')
hold off


%Goodness of Fit
%x=x(2:end);
f1=f(2:end);
f2=f(1:end-1);

%K-S test -->Manualy
diff1=[abs(f1-ylgn) abs(f1-ywbl) abs(f1-ygm) abs(f1-yex)];
diff2=[abs(f2-ylgn) abs(f2-ywbl) abs(f2-ygm) abs(f2-yex)];

diff=[diff1; diff2];

ks=max(diff);

ks=ks';
n=length(f1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%p-value  KS test
[ks_pval]=pval_kstest( n,ks,alpha );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Critical value KS test
cv_ks=sqrt(-0.5*log(0.05/2))/sqrt(length(f1));

clear Mc rate NBIN X a a1 a2 ca2 i inter n south time X c diff epd f freq h k lmax nonz m N r s T x 

save cdf_distributions.mat
