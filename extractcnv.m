function [data2,datahead,tt]=extractcnv

cd ../../'newly extracted'/
file = dir ('*.cnv');
filenames = {file.name};

for i=1:length(filenames)
    fid = fopen(filenames{i});     % open file to read
    fseek(fid,0,-1);
    ix=strfind(filenames{i},'.');  % get the underscore locations
    t=filenames{i}(ix(1)-3:ix(1)-1);     % return the substring up to 2nd underscore
    tt(i)=str2double(t);
    % set read position to beginning of file
    while strcmp(fgetl(fid),'*END*') == 0 end        % go through lines until '*END*'
    n=1;
    while 1
        tline = fgetl(fid);                 % read in line
        if ~ischar(tline), break, end       % if eof, break and finish
        data.(sprintf('station_%d',tt(i)))(:,n) = sscanf(tline,'%f');     % put numbers in a matrix (in columns)
        n=n+1;
    end
end
names=fieldnames(data);
%transpose matrices

for i=1:length(fieldnames(data))
    data.(names{i})=transpose(data.(names{i}));
    data2.(names{i})=zeros(ceil(max(data.(names{i})(:,1))),9);
    dummy=1:ceil(max(data.(names{i})(:,1)));
    %for j=1:ceil(max(data.(names{i})(:,1)))
    startdepth=data.(names{i})(1,1);
    [~,idx]=min(abs(data.(names{i})(:,1)-(startdepth+0.30)));
    data2.(names{i})=data.(names{i});
    if data2.(names{i})(1,1)<=2.2 || length(data2.(names{i})(:,1))>500
        data2.(names{i})(1:idx-1,:)=[];
    end
    data2.(names{i})=[data2.(names{i})(1,:);data2.(names{i})];
    data2.(names{i})(1,1)=0.5;
    %
    %
    %         if data.(names{i})(1,1)>dummy(j)
    %             data2.(names{i})(j,2:9)=ones(1,8)*NaN;
    %             data2.(names{i})(j,1)=j;
    %         else
    %             data2.(names{i})(j,2:end)=mean(data.(names{i})(idx:idx2,2:end));
    %         end
    %  end
    %     data2.(names{i})(:,1)=1:1:ceil(max(data.(names{i})(:,1)));
end
%add headers
header={'depth (m)', 'chlorophyll (μg/l)', 'oxygen (μmol/l)','PAR', 'salinity (psu)','temperature (^{o}C)', 'turbidity (NTU)','SPAR','flag'};

for i=1:length(names)
    datahead.(names{i})=[header; num2cell(data2.(names{i}))];
end

fclose(fid)    % cl
end
%% export as excel with multiple tabs
% for i=1:length(names)
%     sheet = cell2mat(names(i));
%  writecell((datahead.(names{i})),'CTDstations.xlsx','sheet',sheet,'Range','A1');
% end