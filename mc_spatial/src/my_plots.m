function my_plots(table,newcat)
%function to plot output from the my_mc_spatial
%table format
%Mc Mc-boot Mc-unc lon lat b-val b-val-err b-val-boot b-val-unc a-val a-valboot a-val-unc Mmax Nevents

% Keep grid points with Mc val [remove NaNs]
ntable=table(~isnan(table(:,1)),:); 

%% Plot Mc - This is the data Mc
figure
subplot(1,2,1)%Mc
my_map(ntable(:,5), ntable(:,4), ntable(:,1),newcat,'Mc')

subplot(1,2,2)%Uncertainties
my_map(ntable(:,5), ntable(:,4), ntable(:,3),newcat,'Mc uncertainties')

%% Plot Mc - This is the mean value for the bootstrap Mc
figure
subplot(1,2,1)%Mc
my_map(ntable(:,5), ntable(:,4), ntable(:,2),newcat,'Mc boot.')

subplot(1,2,2)%Uncertainties
my_map(ntable(:,5), ntable(:,4), ntable(:,3),newcat,'Mc uncertainties')

%% Plot b-values
figure
subplot(1,2,1)%bvalues
my_map(ntable(:,5), ntable(:,4), ntable(:,6),newcat,'bval')

subplot(1,2,2)%Uncertainties
my_map(ntable(:,5), ntable(:,4), ntable(:,7),newcat,'bval error')
%% Plot b-values
figure
subplot(1,2,1)%bvalues boot
my_map(ntable(:,5), ntable(:,4), ntable(:,8),newcat,'bval boot')

subplot(1,2,2)%Uncertainties
my_map(ntable(:,5), ntable(:,4), ntable(:,9),newcat,'bval uncertainties')

%% Plot a-values
figure
subplot(1,2,1)%bvalues boot
my_map(ntable(:,5), ntable(:,4), ntable(:,11),newcat,'aval boot')

subplot(1,2,2)%Uncertainties
my_map(ntable(:,5), ntable(:,4), ntable(:,12),newcat,'aval uncertainties')



end