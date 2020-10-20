function my_output(table,stime,etime)
%Function to print the output table into an ASCII file

out_file=sprintf('%04d_%04d.txt',stime,etime);

%outputfile
fout=fopen(out_file,'w');
fprintf(fout,'%s\n','Magnitude     N of events   b-value  error-b  a-value  residuals    %%');
fprintf(fout,'%3.1f             %4d         %5.3f   %5.4f    %6.3f     %5.2f    %6.2f \n', table');
fclose(fout);


end