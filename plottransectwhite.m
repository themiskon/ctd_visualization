%plot transects for white ctd

%create indices
id.white1=[391:392];
id.white2=[389:390];
id.white3=[349,377,379:387];
id.white4=[329:336];
id.white7=[368:371,373:376];
id.white5=[337:342,];
id.white8=[358:363];
id.white6=[353:357];
%create indices
id.wh1=[54:55];
id.wh2=[52:53];
id.wh3=[20,42:51];
id.wh4=[4:11];
id.wh7=[34:41];
id.wh5=[12:17];
id.wh8=[26:31];
id.wh6=[21:25];

%start ploting
%transect by transect

%create depth matrix
for transect=3%1:length(fieldnames(id))
    k=1;
    for i=(id.(sprintf('white%d',transect)))
        %depth
        de1=data2.(sprintf('station_%d',(i)))(:,1);
        %de1(de1==0)=0.01;
        p.D(k,1:length(de1)) = de1;
        %chlorophyl
        chl=data2.(sprintf('station_%d',(i)))(:,2);
        p.chl(k,1:length(chl)) = chl.*100;
        %oxygen
        oxy=data2.(sprintf('station_%d',(i)))(:,3);
        p.O(k,1:length(oxy)) = oxy;
        %PAR
        par=data2.(sprintf('station_%d',(i)))(:,4);
        p.PAR(k,1:length(par)) = par;
        %salinity
        sal=data2.(sprintf('station_%d',(i)))(:,5);
        p.S(k,1:length(sal)) = sal;
        %temperature
        tem=data2.(sprintf('station_%d',(i)))(:,6);
        p.T(k,1:length(tem)) = tem;
        k=k+1;
    end
    p.D(p.D==0)=NaN;
    lon=cell2mat({keepst.Dlon});
    plottrans(cell2mat({keepst(id.(sprintf('wh%d',transect))).Dlon}),p.D,p.chl,'chlorophyll (μg l^{-1})')
    title(['transect ',num2str(transect)])
    plottrans(cell2mat({keepst(id.(sprintf('wh%d',transect))).Dlon}),p.D,p.O,'oxygen (μmol l^{-1})')
    title(['transect ',num2str(transect)])
    plottrans(cell2mat({keepst(id.(sprintf('wh%d',transect))).Dlon}),p.D,p.PAR,'PAR (μmolE m^{-2} s^{-1})')
    title(['transect ',num2str(transect)])
    plottrans(cell2mat({keepst(id.(sprintf('wh%d',transect))).Dlon}),p.D,p.S,'salinity (PSU)')
    title(['transect ',num2str(transect)])
    plottrans(cell2mat({keepst(id.(sprintf('wh%d',transect))).Dlon}),p.D,p.T,'temperature (^{o}C)')
    title(['transect ',num2str(transect)])
    clear p
    k=1;
end

