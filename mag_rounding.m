function ar=mag_rounding(a)
%function to round magnitudes
%first plot a histogram with the current magnitudes
%then do the rounding
%plot again a new magnitude histogram (sanity check)
mag=a(:,10);

%Original magnitudes
f1=figure;
Mmn=min(mag); Mmx=max(mag);
bin=0.1; 
histogram(mag,Mmn-0.05:bin:Mmx-0.05)
title('Rounded to 0.01')
xlabel('Magnitude (M)')
ylabel( 'N obs')
set(gca,'FontSize',14,'FontName','Helvetica')
saveas(f1,'hist_mag_original.eps','eps')
close(f1)

%Round
f2=figure;
magnew=round(mag,1);
Mmn=min(magnew); Mmx=max(magnew);
bin=0.1; 
histogram(magnew,Mmn-0.05:bin:Mmx-0.05)
title('Rounded to 0.1')
xlabel('Magnitude (M)')
ylabel( 'N obs')
set(gca,'FontSize',14,'FontName','Helvetica')
saveas(f2,'hist_mag_rounded.eps','eps')
close(f2)

%Replace magnitudes to the original catalog
ar=[a(:,1:9) magnew];

end