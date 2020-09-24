%Script to perform an initial quality control of the Utah
%and later for the western Montana earthquake catalog
clear;clc;close all

%% 00. load catalog
filename='UtahMlMc.txt';
a=read_cat(filename);

%% 01. fix magnitudes -- round to 0.1
ar=mag_rounding(a);
pause
%% 02. Depth distribution
depth_distr(ar);
pause
%% 03. Cum Vs. Time
cum_time(ar);
pause
%% 04. Mag Vs Time
mag_time(ar);
pause
%% 05. Latitude Vs. Time
lat_time(ar);
pause
%% 06. Spatial Map
map_xy(ar)
pause
%% 07. GOF [entire catalog]
MCgft(ar);