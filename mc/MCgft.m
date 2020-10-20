%calculate Magnitude of Completeness                                      %  
%Maximum curvature estimation                                             %
%Goodness of Fit (90%-95%)  [Wiemer and Wyss,2000]                        %
%Input : Catalog data                                                     %
%Format: year mm day hr min sec lat lon depth mag                         %
%                                                                         %
%Output                                                                   %
%figures                                                                  %
%histogram non cumulative                                                 %
%SemilogY plot (Non cumulative, cumulative, Mc)                           %  
%Residuals (Power Law-Observed)                                           % 
                                                                          %
%ASCII files                                                              % 
%Magnitude residuals a errorA b errorB                                    % 
%                                                                         %  
% bug fixed  lines 70-72 --                                               %
% Choose the first magnitude in maxcur matrix if                          %
% the entries are more than one  -- MM Jan-2018                           %
%                                                                         %
% Errors (b-value) are calculated using Shi and Bolt (1982) formula       %       
% -- MM June/2020                                                         %
%                                                                         %
% Misc updates-- works with a .mat file                                   %
%Organized into functions                                                 %
%------------------------------- M.Mesimeri, 10/2020 ----------------------
%--------------------------------------------------------------------------

clear; clc; close all

%% Parameters
filename='northern_utah.mat';     %name of .mat file

stime=1993;                       % Starting time for the catalog [years]
etime=1993;                       % Ending time for the catalog 
%--------------------------------------------------------------------------

%% 00. Add to path
mydir=pwd; pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir));  %add src to path 

%% 01. Load catalog
disp('Catalog...')
newcat=my_load(filename,stime,etime);

%% 02. Cumulative and maximum Curvature
disp('Cumulative and maximum Curvature...')
[Nnoncum,Ncum,maxcur]=do_maxcur(newcat(:,10));

%% 03. Do completeness 
disp('Completeness...')
 table=do_gof(Nnoncum,Ncum,newcat(:,10));
% 
%% 04. Decision time
disp('BREAK........')
disp('Think before acting....')
select_Mc(table,maxcur)
pause

%input magnitude of completeness to create final plot
Mc=input('Give Magnitude of Completeness:');

%% 05. Output File
disp('Output - txt')
my_output(table,stime,etime)

%% 06. Output Figure
disp('Output Figure')
my_figure(table,Mc,Nnoncum,maxcur)
