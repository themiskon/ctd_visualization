p=netcdf_test;

lat = double(p.lat);
lon = double(p.lon);

% prepare a lat/lon grid 
[nlon,nlat,nz,nt]=size(p.T);
[LON, LAT] = meshgrid(lon,lat);
T = squeeze(p.T(:,:,1,2));
S = squeeze(p.S(:,:,1,2));
Sp= squeeze(p.Sp(:,:,1));
%size(salt)
%depth, time
figure,
worldmap([55.6 56.],[12.3 13.0])
hg = geoshow(LAT,LON,T','DisplayType','surface');
colorbar
%caxis([15 20])
hold on
set(hg,'ZData',get(hg,'ZData')-1000000)

LL = load('coastline_oresund.dat');
hh=plotm(LL(:,2),LL(:,1),'k','linewidth',2);
hold on
title('Temperature (degC)')

%
figure,
worldmap([55.6 56.],[12.3 13.0])
hg = geoshow(LAT,LON,S','DisplayType','surface');
colorbar
%caxis([5 10])
hold on
set(hg,'ZData',get(hg,'ZData')-1000000)

LL = load('C:\Users\Themis\Desktop\Aquatic field work/coastline_oresund.dat');
hh=plotm(LL(:,2),LL(:,1),'k','linewidth',2);
hold on
title('Salinity (psu)')

%
figure,
worldmap([55.6 56.],[12.3 13.0])
hg = geoshow(LAT,LON,Sp','DisplayType','surface');
colorbar
%caxis([5 10])
hold on
set(hg,'ZData',get(hg,'ZData')-1000000)

LL = load('C:\Users\Themis\Desktop\Aquatic field work/coastline_oresund.dat');
hh=plotm(LL(:,2),LL(:,1),'k','linewidth',2);
hold on
title('Surface surface hight (meters)')

