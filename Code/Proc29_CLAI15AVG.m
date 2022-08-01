clc; clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_MLAI15DE1 = '../output/26_MOD15DLAI/';
Path_PLAICP6DE = '../output/32_PLAICP6DE/GFDLCM4/';
Path_CLAICP6DE = '../output/32_PLAICP6DE/CESM2/';
Path_TLAI15DE1 = '../output/52_TLAI15DE1/';
Path_CLAI15AVG = '../output/29_CLAI15AVG/';

% system(['rm -rf '  ,Path_CLAI15AVG]);
% system(['mkdir -p ',Path_CLAI15AVG]);

YearBgn = 2001;
YearEnd = 2014;
% YearNum = numel(YearBgn:YearEnd);

% read data
[LCT12YE1,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover坐标
Proj        = geotiffinfo([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);

MLAI15AVG = nan([R.RasterSize,YearEnd-YearBgn+1]);
% TLAI15AVG = nan([R.RasterSize,YearEnd-YearBgn+1]);
% PLAI15AVG = nan([R.RasterSize,YearEnd-YearBgn+1]);
CLAI15AVG = nan([R.RasterSize,YearEnd-YearBgn+1]);

% 1) processing
for Year=YearBgn:YearEnd
    MLAI15DE1  = geotiffread([Path_MLAI15DE1,'MOD15DLAI.A',num2str(Year),'.tif']);
    MLAI15AVG(:,:,Year-YearBgn+1)= nanmean(MLAI15DE1,3);
    disp(['Done with reading ',num2str(Year)]);
end

% for Year=YearBgn:YearEnd
%     TLAI15DE1  = geotiffread([Path_TLAI15DE1,'TLAI15DE1.A',num2str(Year),'.tif']);
% %     TLAI15AVG(:,:,Year-YearBgn+1)= mean(TLAI15DE1,3);
%     TLAI15AVG(:,:,Year-YearBgn+1)= nanmean(TLAI15DE1,3);
%     disp(['Done with reading ',num2str(Year)]);
% end

% for Year=YearBgn:YearEnd
%     PLAI15DE1  = geotiffread([Path_PLAICP6DE,'GFDLCM4_LAI_005c.A',num2str(Year),'001.tif']);
%     PLAI15DE1 = PLAI15DE1(1:3000,:,:);
%     PLAI15AVG(:,:,Year-YearBgn+1)= nanmean(PLAI15DE1,3);
%     disp(['Done with reading ',num2str(Year)]);
% end

for Year=YearBgn:YearEnd
    CLAI15DE1  = geotiffread([Path_CLAICP6DE,'CESM2_LAI_005c.A',num2str(Year),'.tif']);
    CLAI15DE1 = CLAI15DE1(1:3000,:,:);
    CLAI15AVG(:,:,Year-YearBgn+1)= nanmean(CLAI15DE1,3);
    disp(['Done with reading ',num2str(Year)]);
end

% write data
FileName=[Path_CLAI15AVG,'OLAI15AVG.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
geotiffwrite(FileName,MLAI15AVG,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% FileName=[Path_CLAI15AVG,'TLAI15AVG.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,TLAI15AVG,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% FileName=[Path_CLAI15AVG,'PLAI15AVG.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,PLAI15AVG,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=[Path_CLAI15AVG,'CLAI15AVG.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
geotiffwrite(FileName,CLAI15AVG,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% % 2) processing statistics for TLAI
% [TAVG15CORR,~] = corr3dnan(MLAI15AVG,TLAI15AVG);
% TAVG15RMSE = rmse3d(MLAI15AVG,TLAI15AVG);
% TAVG15BIAS =  mbe3d(MLAI15AVG,TLAI15AVG);

% write data
% FileName=[Path_CLAI15AVG,'TAVG15CORR.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,TAVG15CORR,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% % FileName=[Path_CLAI15AVG,'TAVG15PROB.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% % geotiffwrite(FileName,TAVG15PROB,R,'GeoKeyDirectoryTag',...
% %     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15AVG,'TAVG15RMSE.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,TAVG15RMSE,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15AVG,'TAVG15BIAS.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,TAVG15BIAS,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% % 2) processing statistics for PLAI
% [PAVG15CORR,~] = corr3dnan(MLAI15AVG,PLAI15AVG);
% PAVG15RMSE = rmse3d(MLAI15AVG,PLAI15AVG);
% PAVG15BIAS =  mbe3d(MLAI15AVG,PLAI15AVG);

% % write data
% FileName=[Path_CLAI15AVG,'PAVG15CORR.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,PAVG15CORR,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% % FileName=[Path_CLAI15AVG,'TAVG15PROB.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% % geotiffwrite(FileName,TAVG15PROB,R,'GeoKeyDirectoryTag',...
% %     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15AVG,'PAVG15RMSE.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,PAVG15RMSE,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15AVG,'PAVG15BIAS.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,PAVG15BIAS,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% 2) processing statistics for CLAI
[CAVG15CORR,~] = corr3dnan(MLAI15AVG,CLAI15AVG);
CAVG15RMSE = rmse3d(MLAI15AVG,CLAI15AVG);
CAVG15BIAS =  mbe3d(MLAI15AVG,CLAI15AVG);

% write data
FileName=[Path_CLAI15AVG,'CAVG15CORR.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
geotiffwrite(FileName,CAVG15CORR,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15AVG,'TAVG15PROB.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,TAVG15PROB,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
FileName=[Path_CLAI15AVG,'CAVG15RMSE.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
geotiffwrite(FileName,CAVG15RMSE,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
FileName=[Path_CLAI15AVG,'CAVG15BIAS.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
geotiffwrite(FileName,CAVG15BIAS,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
