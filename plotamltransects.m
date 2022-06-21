%plot transects
%plots transects, takes aml file output and station information structures as input
function plotamltransects(aml,idx,prefix)
arguments
    aml struct
    idx struct=set_transects_manual
    prefix string='CTD_'
end
amlnames=fieldnames(aml);
idnames=fieldnames(idx);
%% transects black ctd
for i=[4,6]%1:length(idnames)
    k=1;
    %create variable matrices
    for j=idx.(sprintf('Tr%d',i))
        %depth
        de1=cell2mat({aml.(sprintf('CTD_%d',(j))).Depth});
        de1(de1==0)=0.01;
        D(k,1:length(de1)) = de1;
        %temperature
        te1=cell2mat({aml.(sprintf('CTD_%d',(j))).TempCT});
        T(k,1:length(te1)) = te1;
        %Salinity
        sa1=cell2mat({aml.(sprintf('CTD_%d',(j))).Salinity});
        S(k,1:length(sa1)) = sa1;
        %DOM
        do1=cell2mat({aml.(sprintf('CTD_%d',(j))).DOM});
        DOM(k,1:length(do1)) = do1;
        %turbidity
        tu1=cell2mat({aml.(sprintf('CTD_%d',(j))).Turbidity});
        TUR(k,1:length(tu1)) = tu1;
        k=k+1;
        clear de1 te1 sa1 do1 tu1
    end
    D(D==0)=NaN;
    T(T==0)=NaN;
    S(S==0)=NaN;
    DOM(DOM==0)=NaN;
    TUR(TUR==0)=NaN;

    %% plots
    %plot temperature
    
    plottrans(aml.lon(idx.(sprintf('Tr%d',i))),D,T,'temperature (^{o}C)')
    title(['transect ',num2str(i)],'FontWeight','normal')
    %plot salinity
    plottrans(aml.lon(idx.(sprintf('Tr%d',i))),D,S,'salinity (PSU)')
     title(['transect ',num2str(i)],'FontWeight','normal')
    %plot DOM
    plottrans(aml.lon(idx.(sprintf('Tr%d',i))),D,DOM,'DOM')
     title(['transect ',num2str(i)],'FontWeight','normal')
    %plot NTU
    plottrans(aml.lon(idx.(sprintf('Tr%d',i))),D,TUR,'Turbidity (NTU)')
     title(['transect ',num2str(i)],'FontWeight','normal')
     clear D T S DOM TUR
end
end