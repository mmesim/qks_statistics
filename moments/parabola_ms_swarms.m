function [p,S,delta,Con]=parabola_ms_swarms(x,y,ms,swarms,filename)
% Function to fit parabola for MS-AS and earthquake swarms
% It would be useful if you run first the moments.m
% Then you can decide which seqeucnes are swarms and MS-AS
% Input:
%X : vector for skewness
%Y : vector for kurtosis
%ms: vector with ms indices
%swarms: vector with swarms indices
%filename: string to the output diary file

diary(filename)
%calculate quadratic equation 
[p,S]=polyfit(x,y,2)
xnew=min(x)-1:1:max(x)+1;
[yy,delta]=polyval(p,xnew,S);
%%
figure
plot(x(ms),y(ms),'o','MarkerEdgeColor','k','MarkerFaceColor',[157/255 0 157/255],'MarkerSize',8)
xlabel('Skewness','FontSize',14)
ylabel('Kurtosis','FontSize',14)
set(gca,'FontSize',14,'FontName','Helvetica')
hold on
plot(x(swarms),y(swarms),'s','MarkerEdgeColor','k','MarkerFaceColor',[229/255 204/255 1],'MarkerSize',8)
legend('MS-AS','Swarms')
%%
%95% percent
plot(xnew,yy,'c--','LineWidth',2)
plot(xnew,yy+2*delta,'k:','LineWidth',2)
plot(xnew,yy-2*delta,'k:','LineWidth',2)
hold off
p1=polyfit(xnew,yy+2*delta,2);
Con=p1-p;

%%
disp('Confidence Limits:')
disp('a = [');disp(p(1,1)-Con(1,1));disp(p(1,1)+Con(1,1));disp(' ]')
disp('b = [');disp(p(1,2)-Con(1,2));disp(p(1,2)+Con(1,2));disp(' ]')
disp('c = [');disp(p(1,3)-Con(1,3));disp(p(1,3)+Con(1,3));disp(' ]')

disp('symmetry around :')
disp(-p(1,2)/(2*p(1,1)))


diary off


end