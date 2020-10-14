function my_output(table,stime,etime)
%Function to write in txt file the output table
%NaNs are removed

%Mc Mc-boot Mc-unc lon lat b-val b-val-err b-val-boot b-val-unc a-val a-valboot a-val-unc Mmax Nevents
% Keep grid points with Mc val [remove NaNs]
ntable=table(~isnan(table(:,1)),:); 

%Filename for output file
out_file=sprintf('%04d_%04d.txt',stime,etime);

fout=fopen(out_file,'w');
fprintf(fout,'This is the header...\n');
fprintf(fout,'01:Mc 02:Mc from bootstrap 03:Mc bootstrap uncertainties 04:Longitude 5:Latitude \n');
fprintf(fout,'06: b-val 07: b-val error 08: b-val from bootstrap 09: bval bootstrap uncertainties \n');
fprintf(fout,'10: a-values 11:a-values from bootstap 12: a-values uncertainties 13:Mmax 14: N of events \n');

fprintf(fout,'%5.3f %5.3f %5.3f %9.4f %9.4f %5.3f %5.3f %5.3f %5.3f %5.3f %5.3f %5.3f %3.1f %04d \n ',ntable');

fclose(fout);


end