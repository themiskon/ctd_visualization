%extract CTD AML
% return structure named aml, which contains all station data + 2 extra
% fields for latitude and longitude
function aml=extractCTDAML
%the following two lines find the folder where the raw aml files are, there
%are two cd functions, this is not correct, but we left it like this
cd 'C:\Users\Themis\Desktop\Aquatic field work\CTD data\25324 Aquatic field work Jun 22 - 6132022 - 314 PM'
cd ../../'CTD AML'/

%create a directory that contains all .aml files
file = dir ('*.aml');
filenames = {file.name};

for i=1:length(filenames)
    A=readtable(char(filenames(i)),FileType='text');%,NumHeaderLines=116);
    ix=strfind(filenames(i),'.');
    t=filenames{i}(cell2mat(ix(1))-19:cell2mat(ix(1))-1);
    if height(A)<211
        A(1:106,:)=[];
        A(:,2)=[];
        for j=1:height(A)
            [tps] =split(A{j,:},',');
            B(j).Columns_Date = char(tps{1});
            B(j).Time = char(tps{2});
            B(j).Cond = str2double(tps{4});
            B(j).TempCT = str2double(tps{6});
            B(j).Pressure = str2double(tps{8});
            B(j).Turbidity = str2double(tps{10});
            B(j).Chloro_blue = str2double(tps{12});
            B(j).DOM = str2double(tps{14});
            B(j).Salinity = str2double(tps{16});
            B(j).Depth = str2double(tps{19});
        end
        aml.(sprintf('CTD_%d',(i)))=B;
    else
        A(:,[3,5,7,9,11,13,15,17,18])=[];
        A(1,:)=[];
        A=table2struct(A);
        aml.(sprintf('CTD_%d',(i)))=A;
    end
end

%% extract coordinates for stations
for i=1:length(filenames)
    text = fileread(char(filenames(i)));
    ix=strfind(text,'GPSLongitude=');
    ix2=strfind(text,'GPSLatitude=');
    t=text(ix(1)+13:ix(1)+21);
    t2=text(ix2(1)+12:ix2(1)+20);
    aml.lon(i)=str2double(t);
    aml.lat(i)=str2double(t2);
end
end