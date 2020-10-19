% Script to calculate Mc with time
% using the Maximum Curvature method
% % Alternatively you can use this --> 
% http://www.seismo.ethz.ch/en/research-and-teaching/products-software/software/ZMAP/
%
%---------------       M. Mesimeri (10/2020)         ---------------------%
clear;clc;close all;tic
%% Parameters
Nwin=150;           %Number of events in a given window
Nstep=10;
%After Mc
N=50;               % Minimum Number of events after applying Mc
%This works better in case you want to split the catalog into sup-periods
stime=1981;         % Starting time for the catalog [years]
etime=2016;         % Ending time for the catalog 
%Uncertainties
Nboot=200;          %Number of bootstraps for Mc uncertainties  
%.mat filename
filename='northern_utah.mat';    
%set number of workers for parpool
workers=3;
%--------------------------------------------------------------------------
%Input: Earthquake catalog
%Format: .mat file [variable whatever] - 
%10 columns - Year month day hr min sec lat lon depth mag

%% 00. Add to path
parpool('local',workers); %Start parallel pool
mydir=pwd; pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir));  %add src to path 
%% 01. Load catalog
disp('Catalog...')
newcat=my_load(filename,stime,etime);

%% 02. Mc with time
disp('Start calc...')
table=my_mc_time(newcat,Nwin,Nstep,N,Nboot);

%% 03. Figures 
 my_plots(table,Nstep)

%% 04. Shutdown parallel pool
delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer
