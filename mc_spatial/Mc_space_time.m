% Script to calculate Spatial distribution of Mc 
% using the Maximum Curvature method
% It works with radius around a grid of nodes
% Alternatively you can use this --> 
% http://www.seismo.ethz.ch/en/research-and-teaching/products-software/software/ZMAP/
%
% M_map is required (+ gshhs high resolution)
%
%---------------       M. Mesimeri (10/2020)         ---------------------%
clear;clc;close all;tic
%% Parameters
%Spatial Parameters
x=0.1;              % Step in Longitude (deg)
y=0.1;              % Step in Latitude (deg)
r=50;               % Radius around each node (km)
%After Mc
N=50;               % Minimum Number of events after applying Mc
%This works better in case you want to split the catalog into sup-periods
stime=1981;         % Starting time for the catalog [years]
etime=1985;         % Ending time for the catalog 
%Uncertainties
Nboot=200;          %Number of boottrabs for Mc uncertainties  
%.mat filename
filename='utah.mat';    
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

%% 02. Grid points 
disp('Grid...')
nodes=make_grid(newcat,x,y);

%% 03. Mc - bval - aval calculations
disp('Start calc...')
table=my_mc_spatial(nodes,newcat,r,N,Nboot);

%% 04. Figures
my_plots(table,newcat)

%% 05. Output File
my_output(table,stime,etime)

%% 06. Shutdown parallel pool
delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer
