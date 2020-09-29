%Script to perform an initial quality control of the Utah
%and later for the western Montana earthquake catalog
clear;clc;close all

%% add to path
mydir=pwd; pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir));  %add src to path 

%% 00. load catalog
filename='UtahMlMc.txt'; %filename or full path with filename
% Format: Year MonthDayHrMinSec Lat Lon Depth Mag [6 columns - no strings]
a=read_cat(filename);
%% 01. fix magnitudes -- round to 0.1
disp('Magnitude histograms')
ar=mag_rounding(a);
pause 
%% 02. Depth distribution
disp('Depth histogram')
depth_distr(ar);
pause
%% 03. Cum Vs. Time
disp('Cumulative Vs Time')
cum_time(ar);
pause
%% 04. Mag Vs Time
disp('Magnitude Vs Time')
mag_time(a);
pause
%% 05. Latitude Vs. Time
disp('Latitude Vs Time')
lat_time(ar);
pause
%% 06. Spatial Map
disp('Map of the area')
map_xy(ar)
pause
%% 07. GOF [entire catalog]
MCgft(ar);