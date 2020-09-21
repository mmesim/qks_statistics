function all=MCgft(a)

%calculate Magnitude of Completeness                                    %  
%Maximum curvature estimation                                           %
%Goodness of Fit (90%-95%)  [Wiemer and Wyss,2000]                      %
%Input : Catalog data                                                   %
%Format: year mmdayhrminss lat lon depth mag                            %
                                                                        %
%Output                                                                 %
%figures                                                                %
%histogram non cumulative                                               %
%SemilogY plot (Non cumulative, cumulative, Mc)                         %  
%Residuals (Power Law-Observed)                                         % 
                                                                        %
%ASCII files                                                            % 
%Magnitude residuals a errorA b errorB                                  %
%                                                                       %  
% bug fixed  lines 70-72 --                                             %
% Choose the first magnitude in maxcur matrix if                        %
% the entries are more than one  -- MM Jan-2018                         %
%                                                                       %
% Errors (b-value) are calculated using Shi and Bolt (1982) formula     %       
% -- MM June/2020                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Magnitude
mag=a(:,10);

%counting observations for each magnitude bin
wmag=min(mag):0.1:max(mag);
[Robs,index]=hist(mag,wmag);

%Non Cumulative
N=[wmag' Robs'];

N=N(N(:,2)>0,:);

%cumulative N of earthquakes
NC1=flipud(N(:,2));
NC2=cumsum(NC1);
N2=flipud(N(:,1));

NC=[N2 NC2];

%Estimate maximum curvature
maxcur=N(N(:,2)==max(N(:,2)),1);
%%%%%%%%%%% BUG FIXED %%%%%%%%%%%%
if length(maxcur(:,1)>1)
    maxcur=maxcur(1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

clear NC1 N2 NC2

%reshape cumulative Number of events
RNC=flipud(NC(:,:));

%estimate a and bval (+errors) (MLE, Aki 1965)
for i=1:length(N(:,1))
ind=find(mag(:) >= N(i,1)-0.0499);
mag_new=mag(ind);
avg_mag=mean(mag_new);
  
%b value
bval(i)=log10(exp(1))/(avg_mag-(RNC(i,1)-0.05));
%a value
aval(i)=log10(RNC(i,2))+(bval(i)*RNC(i,1));

%error b
%error_b(i)=bval(i)/RNC(i,2); %simple approach
%Shi and Bolt, 1982
error_b(i)=(2.30*bval(i).^2)*(sqrt(sum((mag_new-avg_mag).^2)/(RNC(i,2)*(RNC(i,2)-1))));
%theoretical
y_synth=10.^(aval(i)-bval(i)*RNC(i:end,1));

%residuals
residuals(i)=100*(sum(abs(y_synth-RNC(i:end,2))))/sum(RNC(i:end,2));

%Observed Vs Theoretical 
semilogy(N(:,1),N(:,2),'^','MarkerEdge','k','MarkerFace','r')
hold on 
semilogy(NC(:,1),NC(:,2),'s','MarkerEdge','k','MarkerFace','k')
semilogy(RNC(i:end,1),y_synth,'m:','LineWidth',2)
title('FMD','FontSize',14)
xlabel ('Magnitude','FontSize',14)
ylabel('Number of earthquakes','FontSize',14)
legend ('Non-Cummulative','Cummulative')
xlim([min(mag) max(mag)])
axis square

clear mag_new avg_mag ind
end
hold off

%histogram
figure
hist(mag,wmag)
axis square
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','k')
xlabel('Magnitude','FontSize',14)
ylabel('Number of events','FontSize',14)
xlim([min(mag) max(mag)])

clear h
%Magnitude Cumulative b error b a Res
all=[RNC bval' error_b' aval' residuals' 100-residuals'];

limited=all(all(:,1)>=maxcur-0.5499 & all(:,1)<=maxcur+2,:);

%define MC based on GOF
MC90_95=all(all(:,7)>=90 ,:);

fprintf('Maximum Curvature: %3.1f \n',maxcur)
display('              MC90 - 95      ')
display('Magnitude     N of events   b-value  error-b  a-value  residuals    %%')
fprintf('%3.1f             %4d         %5.3f   %5.4f    %6.3f     %5.2f    %6.2f \n', MC90_95');

%residuals plot
figure
plot(limited(:,1),limited(:,6),'k-^','MarkerEdge','k','LineWidth',1.5,'MarkerSize',10)
axis square
xlabel('Magnitude','FontSize',14)
ylabel('Residual in %','FontSize',14)
ylim([0 40])
xlim([maxcur-0.5 maxcur+1.5])
hold on
plot(limited(:,1),10*ones(1,length(limited(:,1))),':k','LineWidth',1.5)
plot(limited(:,1),5*ones(1,length(limited(:,1))),':k','LineWidth',1.5)

%outputfile
fout=fopen('completeness.txt','w');
fprintf(fout,'%s\n','Magnitude     N of events   b-value  error-b  a-value  residuals    %%');
fprintf(fout,'%3.1f             %4d         %5.3f   %5.4f    %6.3f     %5.2f    %6.2f \n', all');
fclose(fout);

disp('BREAK........')
disp('Think before acting....')
pause

%input magnitude of completeness to create final plot
Mc=input('Give Magnitude of Completeness:');

%Magnitude of completeness
ind=find(all(:,1)>=Mc-0.0499 & all(:,1)<Mc+0.0499,6);
y=all(ind,6);
xnew=RNC(RNC(:,1)>=Mc-0.0499,1);
ynew=10.^(all(ind,5)-all(ind,3)*xnew);
%Ticks
ticks1=maxcur-0.5:0.2:maxcur+1.5;
ticks2=min(RNC(:,1)):0.5:max(RNC(:,1));

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
semilogy(NC(:,1),NC(:,2),'s','MarkerEdge','k','MarkerFace','k')
semilogy(xnew,ynew,'m-','LineWidth',2)
title('FMD','FontSize',14)
xlabel ('Magnitude','FontSize',14)
ylabel('Number of earthquakes','FontSize',14)
legend ('Non-Cumulative','Cumulative')
xlim([min(mag) max(mag)])
set(gca,'XTick',ticks2)
axis square
text(xnew(4)+0.05,ynew(1),['M_c= ' num2str(Mc)],'HorizontalAlignment','center','FontSize',12)


end
