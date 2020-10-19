function my_figure(time, val,unc,mystring,Nstep)
%Function to plot c with time
%Using filter to smooth results

%% Interpolate for NaN values [linear interpolation]
x=1:length(val);
val(isnan(val)) = interp1(x(~isnan(val)),val(~isnan(val)),x(isnan(val))) ;
unc(isnan(unc)) = interp1(x(~isnan(unc)),unc(~isnan(unc)),x(isnan(unc)));

%% this hack is taken from plot_McBwtime.m
% Zmap 6.? -- thank you Zmap
nval= filter(ones(1,Nstep)/Nstep,1,val);
nval(1:Nstep,1)=val(1:Nstep,1);

%Do the same for unc.
Upunc=val+unc;
nUpunc= filter(ones(1,Nstep)/Nstep,1,Upunc);
nUpunc(1:Nstep,1)=Upunc(1:Nstep,1);

Dwunc=val-unc;
nDwunc= filter(ones(1,Nstep)/Nstep,1,Dwunc);
nDwunc(1:Nstep,1)=Dwunc(1:Nstep,1);

%% Now do the plot
h=area(time,[nDwunc nUpunc-nDwunc]);
h(1).FaceColor = 'none';
h(1).LineStyle= 'none';
h(2).FaceColor = [211/255 211/255 211/255];
h(2).LineStyle= 'none';
hold on
%plot(time,Upunc,':m','LineWidth',1.0); plot(time,Dwunc,':m','LineWidth',1.0)

plot(time,nval,'k-','LineWidth',2); hold on

xlabel('Time')
ylabel(mystring)
xlim([min(time) max(time)])
ylim([min(nDwunc) max(nUpunc)])
set(gca,'FontSize',14,'FontName','Helvetica')


end
