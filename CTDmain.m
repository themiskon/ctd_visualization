cd 'C:\Users\Themis\Desktop\Aquatic field work\CTD data\25324 Aquatic field work Jun 22 - 6132022 - 314 PM'
addpath('C:\Users\Themis\Desktop\Aquatic field work\CTD data\25324 Aquatic field work Jun 22 - 6132022 - 314 PM')
addpath('C:\Users\Themis\Desktop\Aquatic field work\CTD data')
addpath('C:\Users\Themis\Desktop\Aquatic field work\CTD data\25324 Aquatic field work Jun 22 - 6132022 - 314 PM')

[data2,datahead,tt]=extractcnv;
[A,st]=station_reading([]);
aml=extractCTDAML;

%% keep only CTD stations
stations_all=cell2mat({st.id});
[~,idx]=ismember(tt,stations_all);
keepst=st(idx);

%% remove points above sea surface
removeair
