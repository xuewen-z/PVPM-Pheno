clc; clear;

Path_LandCover = '../input/';
Path_PLAICP6DE = '../output/32_PLAICP6DE/';
Path_PLAIm95 = '../output/33_PLAIm95/';

% system(['rm -rf ',Path_PLAIm95]);
% system(['mkdir -p ',Path_PLAIm95]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

YearBgn = 2001;
YearEnd = 2014; 

PLAIm95 = nan([R.RasterSize,YearEnd-YearBgn+1]);

for Year = YearBgn:YearEnd
    YearName = num2str(Year,'%d');
    
%% 1
%     PLAICP6DE = geotiffread([Path_PLAICP6DE,'GFDLCM4_LAI_005c.A',num2str(Year),'001.tif']);
%     PLAICP6DE = PLAICP6DE(1:3000,:,:);

%% 2 
      PLAICP6DE = geotiffread([Path_PLAICP6DE,'CESM2_LAI_005c.A',num2str(Year),'.tif']);

    PLAIm95 = prctile(PLAICP6DE,95,3);

%     PLAImax = max(PLAICP6DE,[],3);

    FileName = [Path_PLAIm95,'CELAIm95.A',YearName,'.tif'];
    geotiffwrite(FileName,PLAIm95,R,'GeoKeyDirectoryTag',...
         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
 
%      FileName = [Path_PLAIm95,'PLAImax.A',YearName,'.tif'];
%          geotiffwrite(FileName,PLAImax,R,'GeoKeyDirectoryTag',...
%          Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
 
    
    disp(['Done with ',YearName]);
end


