function plottrans(lat,depth,var,name)
addpath 'C:\Users\Themis\Desktop\Aquatic field work\CTD AML'

figure()
for i=1:length(lat)
    d=depth(i,:);
    de=d(~isnan(d));
    va=var(i,:);
    v=va(~isnan(d))';
    scatter(lat(i)*ones(length(de),1),de,36,v','filled');
    noofdots(i)=length(de);
    clear v de d va
    drawnow
    hold on
end
shading interp

% Make a colorbar:
cb = colorbar;

% Set colormap:
cmocean haline

%set up labels
xlabel('longitude (decimal degrees)','FontSize',20)
ylabel('depth (meters)','FontSize',20)
set(gca,'FontSize',20)
ylabel(cb,name,'Rotation',270,'fontSize',20)
cb.Label.Position(1) = 5;
axis ij tight

%we need this:
xi=repmat(lat(1),noofdots(1),1);
D=depth(1,1:noofdots(1))';
V=var(1,1:noofdots)';
for i=2:length(lat)
    xi = [xi; repmat(lat(i),noofdots(i),1)];
    D=[D; depth(i,1:noofdots(i))'];
    V=[V; var(i,1:noofdots(i))'];
end
X = linspace(min(lat),max(lat),500);
% Define some common depths:
Dii = linspace(0,max(max(depth)),500);
S = gridfit(xi,D,V,X,Dii);
p = pcolor((X),Dii,S) ;
shading interp
uistack(p,'bottom')
[c,h]=contour((X),Dii,S,'k','LabelSpacing',400);clabel(c,h,'fontweight','bold'); %'ShowText','on'
% Clarify the location of each measurement:
plot(xi,D,'.','color',0.2*[1 1 1],'MarkerSize',3)
% Plot bathymetry:
%but first create a vector with maximum depths
maxdep=max(depth(1,:));
for i=2:length(lat)
    maxdep=[maxdep;max(depth(i,:))];
end
latsrt=sort(lat);
[~,idx]=ismember(latsrt,lat);
maxdep=flip(maxdep(idx));
p = patch([latsrt max(lat) min(lat)],[flip(maxdep)' max(max(depth))+1 max(max(depth))+1],'k');
set(p,'facecolor',0.5*[1 1 1])

