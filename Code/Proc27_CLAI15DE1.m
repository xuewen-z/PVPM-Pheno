clc; clear;

Path_LandCover = '../input/';
Path_MLAI15DE1 = '../output/26_MLAI15DE1/';
Path_PLAICP6DE = '../output/32_PLAICP6DE/GFDLCM4/';
Path_CLAICP6DE = '../output/32_PLAICP6DE/CESM2/';
Path_TLAI15DE1 = '../output/52_TLAI15DE1/';
Path_CLAI15DE1 = '../output/27_CLAI15DE1/';

% system(['rm -rf '  ,Path_CLAI15DE1]);
% system(['mkdir -p ',Path_CLAI15DE1]);

% 2001-2017 averaged daily LAI
YearBgn = 2001;
YearEnd = 2014;
YearNum = numel(YearBgn:YearEnd);

% MLAI15DE1 = 0;
% for Year=YearBgn:YearEnd
%     Tempor   = geotiffread([Path_MLAI15DE1,'MOD15DLAI.A',num2str(Year),'.tif']);
%     MLAI15DE1= MLAI15DE1 + Tempor;
% end
% MLAI15DE1 = MLAI15DE1 / YearNum;
% disp('Done with reading');
% 
% TLAI15DE1 = 0;
% for Year=YearBgn:YearEnd
%     Tempor   = geotiffread([Path_TLAI15DE1,'TLAI15DE1.A',num2str(Year),'.tif']);
%     TLAI15DE1= TLAI15DE1 + Tempor;
% end
% TLAI15DE1 = TLAI15DE1 / YearNum;
% disp('Done with reading');

% PLAI15DE1 = 0;
% for Year=YearBgn:YearEnd
%     Tempor   = geotiffread([Path_PLAICP6DE,'GFDLCM4_LAI_005c.A',num2str(Year),'001.tif']);
%     PLAI15DE1= PLAI15DE1 + Tempor;
% end
% PLAI15DE1 = PLAI15DE1 / YearNum;
% disp('Done with reading');

CLAI15DE1 = 0;
for Year=YearBgn:YearEnd
    Tempor   = geotiffread([Path_CLAICP6DE,'CESM2_LAI_005c.A',num2str(Year),'.tif']);
    CLAI15DE1= CLAI15DE1 + Tempor;
end
CLAI15DE1 = CLAI15DE1 / YearNum;
disp('Done with reading');


% 
% figure;hold on;
% plot(squeeze(MLAI15DE1(659,1176,:)),'-r')
% plot(squeeze(TLAI15DE1(659,1176,:)),'-b')
% plot(squeeze(PLAI15DE1(659,1176,:)),'-k')

% write data
% MLAI15DE1=round(MLAI15DE1,2);
% TLAI15DE1=round(TLAI15DE1,2);
% PLAI15DE1 = round(PLAI15DE1,2);
% PLAI15DE1 = PLAI15DE1(1:3000,:,:);
CLAI15DE1 = round(CLAI15DE1,2);

[~,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover坐标
Proj        = geotiffinfo([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);

% FileName=[Path_CLAI15DE1,'MLAI15DE1.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,MLAI15DE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% FileName=[Path_CLAI15DE1,'TLAI15DE1.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,TLAI15DE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% FileName=[Path_CLAI15DE1,'PLAI15DE1.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
% geotiffwrite(FileName,PLAI15DE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
FileName=[Path_CLAI15DE1,'CLAI15DE1.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
geotiffwrite(FileName,CLAI15DE1,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


disp(['Done with ',FileName]);

% 2005 daily LAI
% Year = 2005;
% 
% MLAI15DE1 = geotiffread([Path_MLAI15DE1,'AVHRRBUVI04.',num2str(Year),'0101.abl.tif']);
% TLAI15DE1 = geotiffread([Path_TLAI15DE1,'TLAI15DE1.A',num2str(Year),'001.tif']);
% PLAI15DE1 = geotiffread([Path_PLAI15DE1,'CMIP6LAI.A',num2str(Year),'001.tif']);
% disp('Done with reading');
% 
% figure;hold on;
% plot(squeeze(MLAI15DE1(659,1176,:)),'-r')
% plot(squeeze(TLAI15DE1(659,1176,:)),'-b')
% plot(squeeze(PLAI15DE1(659,1176,:)),'-k')
% 
% % write data
% MLAI15DE1=round(MLAI15DE1,2);
% TLAI15DE1=round(TLAI15DE1,2);
% PLAI15DE1=round(PLAI15DE1,2);
% 
% [~,R] = geotiffread([Path_MLAI15DE1,'AVHRRBUVI04.20010101.abl.tif']);
% Proj  = geotiffinfo([Path_MLAI15DE1,'AVHRRBUVI04.20010101.abl.tif']);
% 
% FileName=[Path_CLAI15DE1,'BLAI15DE1.',num2str(Year),'.',num2str(Year),'.tif'];
% geotiffwrite(FileName,MLAI15DE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% FileName=[Path_CLAI15DE1,'TLAI15DE1.',num2str(Year),'.',num2str(Year),'.tif'];
% geotiffwrite(FileName,TLAI15DE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% FileName=[Path_CLAI15DE1,'PLAI15DE1.',num2str(Year),'.',num2str(Year),'.tif'];
% geotiffwrite(FileName,PLAI15DE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% disp(['Done with ',FileName]);
% 
% load handel.mat;sound(y,Fs,16);
