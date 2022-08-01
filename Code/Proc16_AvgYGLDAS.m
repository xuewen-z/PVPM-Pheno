clc;clear;

Path_LandCover = '../input/';
Path_AvgDGLDAS = '../output/14_AvgDGLDAS/';
Path_AvgYGLDAS = '../output/16_AvgYGLDAS/';

system(['rm -rf '  ,Path_AvgYGLDAS]);
system(['mkdir -p ',Path_AvgYGLDAS]);

%Landcover坐标 
RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

AvgDRg = nan([365,R.RasterSize]);
AvgDPre = nan([365,R.RasterSize]);

tic;

%     for Date = 365
parfor Date = 1:365
    DateName= num2str(Date,'%03d');

    % read data
    FileName= dir([Path_AvgDGLDAS,DateName,'/AvgDRg*']);
    AvgDRg(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));

    FileName= dir([Path_AvgDGLDAS,DateName,'/AvgDPre*']);
    AvgDPre(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));

    disp(['Done with ',DateName]);
end
    
toc;

AvgDRg = reshape(AvgDRg,365,[]); 
AvgYRg = sum(AvgDRg,1); 
AvgYRg = reshape(AvgYRg,R.RasterSize);

clear AvgDRg

AvgDPre = reshape(AvgDPre,365,[]); 
AvgYPre = sum(AvgDPre,1);
AvgYPre = reshape(AvgYPre,R.RasterSize);

clear AvgDPre

AvgDTa = nan([365,R.RasterSize]);

%     for Date = 365
for Date = 1:365
    DateName= num2str(Date,'%03d');

    % read data

    FileName= dir([Path_AvgDGLDAS,DateName,'/AvgDTa*']);
    AvgDTa(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));

    disp(['Done with ',DateName]);
end

AvgDTa = reshape(AvgDTa,365,[]); 
RngYTa = max(AvgDTa,[],1) - min(AvgDTa,[],1);
RngYTa = reshape(RngYTa,R.RasterSize);

clear AvgDTa

% write data
YearBgn = 2001;
YearEnd = 2010; 

BgnName = num2str(YearBgn,'%d');
EndName = num2str(YearEnd,'%d');

FileName=['AvgYRg.A',BgnName,'.',EndName,'.001.tif'];
geotiffwrite(fullfile(Path_AvgYGLDAS,FileName),AvgYRg,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=['AvgYPre.A',BgnName,'.',EndName,'.001.tif'];
geotiffwrite(fullfile(Path_AvgYGLDAS,FileName),AvgYPre,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=['RngYTa.A',BgnName,'.',EndName,'.001.tif'];
geotiffwrite(fullfile(Path_AvgYGLDAS,FileName),RngYTa,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

