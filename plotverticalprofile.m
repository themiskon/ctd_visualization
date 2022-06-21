%vertical plots of ctds

%This code uses a modified version of addaxis code, available in mathworks
%database.
function plotverticalprofile(data2,station)

arguments
data2 struct
station double = 349
end

addpath 'C:\Users\Themis\Desktop\Aquatic field work\addaxis6'

h=plot(cell2mat({data2.(sprintf('station_%d', station))(:,1)}),cell2mat({data2.(sprintf('station_%d', station))(:,6)}),'LineWidth',2);
set(get(gca,'YLabel'),'Rotation',90)
set(gca,'fontsize',16)
ytickangle(90)
xtickangle(90)
xlabel('depth (m)','Rotation',180,'Position',[mean(cell2mat({data2.(sprintf('station_%d', station))(:,1)}))-2 min(cell2mat({data2.(sprintf('station_%d', station))(:,6)}))-0.12])
% set(h_ax, 'FontSize',20)
addaxis(cell2mat({data2.(sprintf('station_%d', station))(:,1)}),cell2mat({data2.(sprintf('station_%d', station))(:,5)}));
addaxis(cell2mat({data2.(sprintf('station_%d', station))(:,1)}),cell2mat({data2.(sprintf('station_%d', station))(:,3)}));
addaxis(cell2mat({data2.(sprintf('station_%d', station))(:,1)}),cell2mat({data2.(sprintf('station_%d', station))(:,2)}).*100);

addaxislabel(1,'temperature (^{o}C)');
addaxislabel(2,'salinity (PSU)');
addaxislabel(3,'oxygen (μmol l^{-1})');
addaxislabel(4, 'chlorophyll (μg l^{-1})');
end