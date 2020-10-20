function table=do_gof(N,RNC,mag)
%function to calculat Mc using the Goodness of Fit method
%For details check (Wiemer and Wyss, 2000)

% Pre-allocate 
table=NaN*ones(length(N(:,1)),7);

for i=1:length(N(:,1))

%Find events for given magnitude bin    
ind=mag(:) >= N(i,1)-0.0499;
mag_new=mag(ind);

%Calculate mean magnitude
avg_mag=mean(mag_new);
  
%b value
bval=log10(exp(1))/(avg_mag-(RNC(i,1)-0.05));
%a value
aval=log10(RNC(i,2))+(bval*RNC(i,1));

%error b
%error_b(i)=bval(i)/RNC(i,2); %simple approach
%Shi and Bolt, 1982
error_b=(2.30*bval.^2)*(sqrt(sum((mag_new-avg_mag).^2)/(RNC(i,2)*(RNC(i,2)-1))));
%theoretical
y_synth=10.^(aval-bval*RNC(i:end,1));

%residuals
residuals=100*(sum(abs(y_synth-RNC(i:end,2))))/sum(RNC(i:end,2));

%Observed Vs Theoretical 
semilogy(N(:,1),N(:,2),'^','MarkerEdge','k','MarkerFace','r')
hold on 
semilogy(flipud(RNC(:,1)),flipud(RNC(:,2)),'s','MarkerEdge','k','MarkerFace','k')
semilogy(RNC(i:end,1),y_synth,'m:','LineWidth',2)
title('FMD','FontSize',14)
xlabel ('Magnitude','FontSize',14)
ylabel('Number of earthquakes','FontSize',14)
legend ('Non-Cumulative','Cumulative')
xlim([min(mag) max(mag)])
axis square

%Magnitude Cumulative b error b a Res
table(i,:)=[RNC(i,:) bval error_b aval residuals 100-residuals];
end


end