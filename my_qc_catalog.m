%Script to perform an initial quality control of the Utah
%and later for the western Montana earthquake catalog
clear;clc;close all

%% 00. load catalog
filename='Utah.txt';
a=read_cat(filename);

%% 01. fix magnitudes -- round to 0.1
ar=mag_rounding(a);

%% 02. Depth distribution
depth_distr(ar);
%% 03. Cum Vs. Time
cum_time(ar);
%% 04. Mag Vs Time
mag_time(ar);
%% 05. Latitude Vs. Time
lat_time(ar);
%% 06. Spatial Map
map_xy(ar)
%% 07. GOF [entire catalog]
MCgft(ar);