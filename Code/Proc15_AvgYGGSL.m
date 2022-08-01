clc;clear;

Path_LandCover = '../input/';
Path_AvgDGLDAS = '../output/14_AvgDGLDAS/';
Path_AvgYGGSL = '../output/15_AvgYGGSL/';

% system(['rm -rf '  ,Path_AvgYGGSL]);
% system(['mkdir -p ',Path_AvgYGGSL]);

%Landcover坐标 
RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  
[LCT12YE,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

AvgDIGSI = nan([365,R.RasterSize]);

tic;

%     for Date = 365
parfor Date = 1:365
    DateName= num2str(Date,'%03d');

    % read data
    FileName= dir([Path_AvgDGLDAS,DateName,'/AvgDIGSI*']);
    AvgDIGSI(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));

%         FileName= dir([Path_NorhDGLDAS,DateName,'/AvgDVPD*']);
%         AvgDTmn(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));
%    
%         FileName= dir([Path_NorhDGLDAS,DateName,'/AvgDPho*']);
%         AvgDTmn(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));

    disp(['Done with ',DateName]);
end

toc;

AvgDIGSI = movavg(AvgDIGSI,'simple',21);
AvgDIGSI = reshape(AvgDIGSI,365,[]);
FGSI = mean(AvgDIGSI,1);

AvgYGGSL = sum((AvgDIGSI-0.1)>0,1);
AvgYGGSL = reshape(AvgYGGSL,R.RasterSize);
AvgFGSI = reshape(FGSI,R.RasterSize);

% write data
YearBgn = 2001;
YearEnd = 2010; 

BgnName = num2str(YearBgn,'%d');
EndName = num2str(YearEnd,'%d');

FileName=['AvgYGGSL.A',BgnName,'.',EndName,'.001.tif'];
geotiffwrite(fullfile(Path_AvgYGGSL,FileName),AvgYGGSL,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=['AvgFGSI.A',BgnName,'.',EndName,'.001.tif'];
geotiffwrite(fullfile(Path_AvgYGGSL,FileName),AvgFGSI,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


