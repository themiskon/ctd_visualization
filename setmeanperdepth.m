% create a structure that contains ctd data for specified points and
% calculate the mean for a one meter resolution
function [transect]=setmeanperdepth(aml,amlind)
%Function that set ups transects from aml data conversion. requires two
%inputs: aml -> structure that contains ctd data, amlind -> structure that
%contains transect intices, see set_up_transects_manualy
arguments
aml struct
amlind struct=set_transects_manual
end
%%
amlnames=fieldnames(aml);
namesind=fieldnames(amlind); 
%correction for longitute
% % [~,indexeslon] = sort(aml.lon);
ix_all=amlind.Tr1;
if length(namesind)>1
    for i=2:length(namesind)
        ix_all=[ix_all , amlind.(sprintf('Tr%i',i))];
    end
end

%%transfercoordinates
transect.aml.lat=aml.lat(ix_all);
transect.aml.lon=aml.lon(ix_all);

%inspect remaining station locations
plot(transect.aml.lon,transect.aml.lat,'o')

%% take averages every meter 

for i=ix_all
    Ridxmax=ceil(max(cell2mat({aml.(amlnames{i})(:).Depth})));
    depthid=1;
    for j=1:Ridxmax
        [~,didx]=min(abs(cell2mat({aml.(amlnames{i})(:).Depth})-j));
        transect.aml.(sprintf('st_%d',i))(j).Cond = mean(cell2mat({aml.(amlnames{i})(depthid:didx).Cond}));
        transect.aml.(sprintf('st_%d',i))(j).TempCT = mean(cell2mat({aml.(amlnames{i})(depthid:didx).TempCT}));
        transect.aml.(sprintf('st_%d',i))(j).Pressure = mean(cell2mat({aml.(amlnames{i})(depthid:didx).Pressure}));
        transect.aml.(sprintf('st_%d',i))(j).Turbidity = mean(cell2mat({aml.(amlnames{i})(depthid:didx).Turbidity}));
        transect.aml.(sprintf('st_%d',i))(j).Chloro_blue = mean(cell2mat({aml.(amlnames{i})(depthid:didx).Chloro_blue}));
        transect.aml.(sprintf('st_%d',i))(j).DOM = mean(cell2mat({aml.(amlnames{i})(depthid:didx).DOM}));
        transect.aml.(sprintf('st_%d',i))(j).Salinity = mean(cell2mat({aml.(amlnames{i})(depthid:didx).Salinity}));
        transect.aml.(sprintf('st_%d',i))(j).Depth = j;
        depthid=didx+1;
    end
end