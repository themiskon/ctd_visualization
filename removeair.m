% remove above water and upcast

% CTDmain
amlnames=fieldnames(aml);

for i=1:length(amlnames)-2
    %removal of all values above depth=0.5
    [~,idxair]=find(cell2mat({aml.(amlnames{i})(:).Depth})<=0.5);
    aml.(amlnames{i})(idxair)=[];
    %removal of all upcast values
    [~,idxmax]=max(cell2mat({aml.(amlnames{i})(:).Depth}));
    aml.(amlnames{i})(idxmax+1:end)=[];
    %find if there are NaN depths and remove the values | just noticed I
    %forgot the remove part :p
    [~,idxnan]=find(isnan(cell2mat({aml.(amlnames{i})(:).Depth})));
end
