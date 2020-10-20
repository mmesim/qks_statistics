function my_figure(table,Mc,N,maxcur)
%Function to create the final plot


%Limit the output to Maximum curvature magnitude [maxcur-0.5 maxcur+2.0]
limited=table(table(:,1)>=maxcur-0.5499 & table(:,1)<=maxcur+2,:);

%Magnitude of completeness
ind=find(table(:,1)>=Mc-0.0499 & table(:,1)<Mc+0.0499,6);
y=table(ind,6);
xnew=table(table(:,1)>=Mc-0.0499,1);
ynew=10.^(table(ind,5)-table(ind,3)*xnew);
%Ticks
ticks1=maxcur-0.5:0.2:maxcur+1.5;
ticks2=min(table(:,1)):0.5:max(table(:,1));

%final figure
%residuals
figure
subplot('position',[0.05 0.3 0.45 0.45])
plot(limited(:,1),limited(:,6),'k-^','MarkerEdge','k','LineWidth',1.5,'MarkerSize',10)
axis square
xlabel('Magnitude','FontSize',14)
ylabel('Residual in %','FontSize',14)
ylim([0 40])
xlim([maxcur-0.5 maxcur+1.5])
hold on
plot(Mc,y,'k-^','MarkerEdge','k','MarkerFace','r','MarkerSize',10)
grid on
set(gca,'XTick',ticks1)
plot(limited(:,1),10*ones(1,length(limited(:,1))),':k','LineWidth',1.5)
plot(limited(:,1),5*ones(1,length(limited(:,1))),':k','LineWidth',1.5)
hold off

%FMD
subplot('position',[0.52 0.3 0.45 0.45])
semilogy(N(:,1),N(:,2),'^','MarkerEdge','k','MarkerFace','r')
hold on 
semilogy(table(:,1),table(:,2),'s','MarkerEdge','k','MarkerFace','k')
semilogy(xnew,ynew,'m-','LineWidth',2)
title('FMD','FontSize',14)
xlabel ('Magnitude','FontSize',14)
ylabel('Number of earthquakes','FontSize',14)
legend ('Non-Cumulative','Cumulative')
xlim([min(table(:,1)) max(table(:,1))])
set(gca,'XTick',ticks2)
axis square
text(xnew(4)+0.05,ynew(1),['M_c= ' num2str(Mc)],'HorizontalAlignment','center','FontSize',12)



end