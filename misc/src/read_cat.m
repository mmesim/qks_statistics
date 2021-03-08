function a=read_cat(filename)
%Open catalog file and read columns
% year - month - day- hr - min - sec - lat - long - depth - mag
%--------------------------------------------------------------------------
fin=fopen(filename);
a=textscan(fin,'%04.0f %02.0f %02.0f %02.0f %02.0f %05.2f %f %f %5.2f %5.2f');
fclose(fin);

a=cell2mat(a);

%Keep events with magnitudes
a=a(a(:,10)>-9.99,:);


end