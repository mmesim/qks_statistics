function []=select_Mc(table,maxcur)
%Function to help decide before selecting the Mc
%Outputs residual plot and a few values


%Limit the output to Maximum curvature magnitude [maxcur-0.5 maxcur+2.0]
limited=table(table(:,1)>=maxcur-0.5499 & table(:,1)<=maxcur+2,:);

%define MC based on GOF
MC90_95=table(table(:,7)>=90 ,:);

fprintf('Maximum Curvature: %3.1f \n',maxcur)
disp('              MC90 - 95      ')
disp('Magnitude     N of events   b-value  error-b  a-value  residuals    %%')
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


end