function my_plots(table,Nstep)
%function to plot output from the my_mc_time
%table format
%Mc Mc-boot Mc-unc  b-val b-val-err b-val-boot b-val-unc a-val a-valboot
%a-val-unc Mmax Nevents time


%% Plot Mc - This is the data Mc
figure %Mc
my_figure(table(:,13), table(:,1), table(:,3),'Mc',Nstep)

%% Plot Mc - This is the mean value for the bootstrap Mc
figure%Mc bootstrap
my_figure(table(:,13), table(:,2), table(:,3),'Mc boot',Nstep)

%% Plot b-values
figure%bvalues
my_figure(table(:,13), table(:,4), table(:,5),'b-values',Nstep)

%% Plot b-values
figure%bvalues boot
my_figure(table(:,13), table(:,6), table(:,7),'b-values boot',Nstep)


%% Plot a-values
figure%avalues boot
my_figure(table(:,13), table(:,9), table(:,10),'a-values boot',Nstep)



end