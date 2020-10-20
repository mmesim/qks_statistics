function [N,Ncum,maxcur]=do_maxcur(mag)
%Function to do the cumulative number of events for each magnitude bin
%Also outputs the Mc using the Maximum Curvature method


%counting observations for each magnitude bin
wmag=min(mag):0.1:max(mag);
[Robs,~]=hist(mag,wmag);

%Non Cumulative -- which is actually the histogram
N=[wmag' Robs'];

%Remove magnitudes with no observations
N=N(N(:,2)>0,:);

%cumulative N of earthquakes
NC1=flipud(N(:,2));
NC2=cumsum(NC1);
N2=flipud(N(:,1));

%Merge Cumulative and magnitudes
NC=[N2 NC2];
%reshape cumulative Number of events
Ncum=flipud(NC(:,:));

%--------------------------------------------------------------------------
%Estimate maximum curvature
maxcur=N(N(:,2)==max(N(:,2)),1);
% ---- BUG FIXED % In case there are several mangitudes with "maximum"
% Number of events, just keep the first observation
if ~isempty(maxcur)
    maxcur=maxcur(1,1);
end
%--------------------------------------------------------------------------   



end