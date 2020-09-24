function []=depth_distr(a)
% Plain simple histogram of depths

depth=a(:,9);

figure
histogram(depth,min(depth):0.5:max(depth))
xlabel('Depth (km)')
ylabel('N obs')
set(gca,'FontSize',14,'FontName','Helvetica')

% saveas(f1,'Depth_distr.eps','eps')
% close(f1)
end