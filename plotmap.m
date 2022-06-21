% plot map
stations=setmeanperdepth(aml);
figure,
worldmap([55.6 56.],[12.3 13.0])
LL = load('C:\Users\Themis\Desktop\Aquatic field work/coastline_oresund.dat');
hh=plotm(LL(:,2),LL(:,1),'k','linewidth',2);
depth=1;

fnames=fieldnames(stations.aml);
fnames(1:2)=[];
T(1)=stations.aml.(fnames{1})(depth).TempCT;
for i=2:length(fnames)
    T(i)=stations.aml.(fnames{i})(depth).TempCT;
end
%surfm(stations.aml.lat,stations.aml.lon,T)
%scatterm(stations.aml.lat,stations.aml.lon,1600,T,'.')
% xq=linspace(min(stations.aml.lon):max(stations.aml.lon),50);
% yq=linspace(min(stations.aml.lat):max(stations.aml.lat),50);
[xq,yq] = meshgrid(linspace(min(stations.aml.lon),max(stations.aml.lon),50), linspace(min(stations.aml.lat),max(stations.aml.lat),50));
vq = griddata(stations.aml.lon,stations.aml.lat,T,xq,yq);
surfm(yq,xq,vq)
c=colorbar;
xlabel('longitute')
ylabel('latitude')
ylabel(c, 'temperature (^{o}C)')
title(['temperature at depth= ', num2str(depth),' (m)'])