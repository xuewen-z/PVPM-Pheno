Path_WGS12YPHN = '../output/03_WGS12YPHN/';
Path_DOY12YPHN = '../output/04_DOY12YPHN/';

% system(['rm -rf '  ,Path_DOY12YPHN]);
% system(['mkdir -p ',Path_DOY12YPHN]);

% 86400, 36000
% 1440, 600

% for Year = 2001:2016

for Year = 2001:2018
    YearName = num2str(Year,'%d');

    FileList = dir([Path_WGS12YPHN,'WGS12NUM.A',YearName,'*.tif']);

    % for I_File = 1
    for I_File = 1 : numel(FileList)

        [Pheno,R] = geotiffread(fullfile(FileList(I_File).folder,FileList(I_File).name));
        Proj      = geotiffinfo(fullfile(FileList(I_File).folder,FileList(I_File).name));
        DOY12YPHN = double(Pheno);

       
        Step = size(DOY12YPHN,1)/10;
        for Index = 1: Step :size(DOY12YPHN,1)
            Temp=DOY12YPHN(Index:Index+Step-1,:,:);
%             Temp(Temp<11138)=nan;
%             Temp(Temp>32766)=nan; % phenology mertrics
            Temp(Temp>7)=nan;  % numcycles
            DOY12YPHN(Index:Index+Step-1,:,:)=Temp;
        end

        % change MODIS days to calendar days
%         MOD12BGN = datenum(1970,1,1);
%         MOD12END = datenum(Year-1,12,31);
%         MOD12DAY = MOD12END - MOD12BGN;
% 
%         DOY12YPHN=DOY12YPHN - MOD12DAY;
        
        
%     %     DOY12YPHN(DOY12YPHN> 365)=NaN;
%     %     DOY12YPHN(DOY12YPHN<-365)=NaN;
% 
%     %     DOY12YPHN = gather(DOY12YPHN);
% 
%     %     DOY12YPHN = imaggregation(DOY12YPHN,60,7);
%     %     GeoYAUT=round(GeoYAUT,2);
%     % 
%     %     % write data
%     % 
%     %     RefeName='../input/GLDAS_NOAH025_WORLD.tif'; 
%     % 
%     %     [~,R]= geotiffread(RefeName);
%     %     Proj = geotiffinfo(RefeName);
%     % 
%     %     [GridLon,GridLat]=pixcenters(Proj);
%     %     [LonMesh,LatMesh]=meshgrid(GridLon,GridLat); %坐标

        geotiffwrite([Path_DOY12YPHN,FileList(I_File).name],DOY12YPHN,R,'GeoKeyDirectoryTag',...
            Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

        disp(['Done with ',FileList(I_File).name]);
    end
end