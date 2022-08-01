
clc; clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_MOD15DLAI = '../output/26_MOD15DLAI/';
Path_TLAI15DE1 = '../output/52_TLAI15DE1/';
Path_PLAICP6DE = '../output/32_PLAICP6DE/GFDLCM4/';
Path_CLAICP6DE = '../output/32_PLAICP6DE/CESM2/';
Path_CLAI15DE1 = '../output/27_CLAI15DE1/';
Path_CLAI15YE1 = '../output/28_CLAI15YE1/';

% system(['rm -rf '  ,Path_CLAI15YE1]);
% system(['mkdir -p ',Path_CLAI15YE1]);

% 1) read data for TLAI
% [~,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover坐标
% Proj        = geotiffinfo([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);
% 
% MLAI15DE1  = geotiffread([Path_MOD15DLAI,'MOD15DLAI.A2008.tif']);
% TLAI15DE1  = geotiffread([Path_TLAI15DE1,'TLAI15DE1.A2008.tif']);
% 
% disp('Done with reading');
% 
% % processing statistics
% [CLAI15CORR,~] = corr3dnan(MLAI15DE1,TLAI15DE1);
% CLAI15RMSE = rmse3d(MLAI15DE1,TLAI15DE1);
% CLAI15BIAS =  mbe3d(MLAI15DE1,TLAI15DE1);
% 
% % write data
% FileName=[Path_CLAI15YE1,'TLAI15CORR.2008.2008.tif'];
% geotiffwrite(FileName,CLAI15CORR,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15YE1,'TAVG15PROB.2008.2008.tif'];
% geotiffwrite(FileName,CAVG15PROB,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15YE1,'TLAI15RMSE.2008.2008.tif'];
% geotiffwrite(FileName,CLAI15RMSE,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15YE1,'TLAI15BIAS.2008.2008.tif'];
% geotiffwrite(FileName,CLAI15BIAS,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% disp(['Done with ',FileName]);



% % 2) read data for PLAI
% [~,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover坐标
% Proj        = geotiffinfo([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);
% 
% MLAI15DE1  = geotiffread([Path_MOD15DLAI,'MOD15DLAI.A2008.tif']);
% PLAI15DE1  = geotiffread([Path_PLAICP6DE,'GFDLCM4_LAI_005c.A2008001.tif']);
% PLAI15DE1 = PLAI15DE1(1:3000,:,:);
% 
% disp('Done with reading');
% 
% % processing statistics
% [CLAI15CORR,~] = corr3dnan(MLAI15DE1,PLAI15DE1);
% CLAI15RMSE = rmse3d(MLAI15DE1,PLAI15DE1);
% CLAI15BIAS =  mbe3d(MLAI15DE1,PLAI15DE1);
% 
% % write data
% FileName=[Path_CLAI15YE1,'PLAI15CORR.2008.2008.tif'];
% geotiffwrite(FileName,CLAI15CORR,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% % FileName=[Path_CLAI15YE1,'PAVG15PROB.2008.2008.tif'];
% % geotiffwrite(FileName,CAVG15PROB,R,'GeoKeyDirectoryTag',...
% %     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15YE1,'PLAI15RMSE.2008.2008.tif'];
% geotiffwrite(FileName,CLAI15RMSE,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% FileName=[Path_CLAI15YE1,'PLAI15BIAS.2008.2008.tif'];
% geotiffwrite(FileName,CLAI15BIAS,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% disp(['Done with ',FileName]);


% 2) read data for CLAI
[~,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover坐标
Proj        = geotiffinfo([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);

MLAI15DE1  = geotiffread([Path_MOD15DLAI,'MOD15DLAI.A2008.tif']);
CLAI15DE1  = geotiffread([Path_CLAICP6DE,'CESM2_LAI_005c.A2008.tif']);

disp('Done with reading');

% processing statistics
[CLAI15CORR,~] = corr3dnan(MLAI15DE1,CLAI15DE1);
CLAI15RMSE = rmse3d(MLAI15DE1,CLAI15DE1);
CLAI15BIAS =  mbe3d(MLAI15DE1,CLAI15DE1);

% write data
FileName=[Path_CLAI15YE1,'CLAI15CORR.2008.2008.tif'];
geotiffwrite(FileName,CLAI15CORR,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
FileName=[Path_CLAI15YE1,'CLAI15RMSE.2008.2008.tif'];
geotiffwrite(FileName,CLAI15RMSE,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
FileName=[Path_CLAI15YE1,'CLAI15BIAS.2008.2008.tif'];
geotiffwrite(FileName,CLAI15BIAS,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

disp(['Done with ',FileName]);

% 3) processing average
% MLAI15DE1  = geotiffread([Path_CLAI15DE1,'MLAI15DE1.2001.2017.tif']);
% TLAI15DE1  = geotiffread([Path_CLAI15DE1,'TLAI15DE1.2001.2017.tif']);
% CLAI15DE1  = geotiffread([Path_CLAI15DE1,'PLAI15DE1.2001.2017.tif']);
% CLAI15DE1 = CLAI15DE1(1:3000,:,:);

CLAI15DE1  = geotiffread([Path_CLAI15DE1,'CLAI15DE1.2001.2014.tif']);
disp('Done with reading');

% MLAI15YE1=nanmean(MLAI15DE1,3);
% TLAI15YE1=nanmean(TLAI15DE1,3);
% PLAI15YE1=nanmean(CLAI15DE1,3);
CLAI15YE1=nanmean(CLAI15DE1,3);

% write data
% FileName='MLAI15YE1.2001.2017.tif';
% geotiffwrite([Path_CLAI15YE1,FileName],MLAI15YE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% FileName='TLAI15YE1.2001.2017.tif';
% geotiffwrite([Path_CLAI15YE1,FileName],TLAI15YE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% FileName='PLAI15YE1.2001.2017.tif';
% geotiffwrite([Path_CLAI15YE1,FileName],PLAI15YE1,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName='CLAI15YE1.2001.2014.tif';
geotiffwrite([Path_CLAI15YE1,FileName],CLAI15YE1,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

disp(['Done with ',FileName]);

% load handel.mat;sound(y,Fs,16);% BLAI15YE1=mean(BLAI15DE1,3);
% TLAI15YE1=mean(TLAI15DE1,3);
% PLAI15YE1=mean(PLAI15DE1,3);



% % processing threshold
% BLAI15THR=0.2*(max(BLAI15DE1,[],3)-min(BLAI15DE1,[],3))+min(BLAI15DE1,[],3);
% TLAI15THR=0.2*(max(TLAI15DE1,[],3)-min(TLAI15DE1,[],3))+min(TLAI15DE1,[],3);
% 
% % write data
% FileName='BLAI15THR.2001.2010.tif';
% geotiffwrite([Path_CLAI15YE1,FileName],BLAI15THR,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% FileName='TLAI15THR.2001.2010.tif';
% geotiffwrite([Path_CLAI15YE1,FileName],TLAI15THR,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% disp(['Done with ',FileName]);
% 
% % processing phenology
% File_CLAI15DE1=dir([Path_CLAI15DE1,'/*tif']);
% 
% for I_File = 2
% % for I_File = 1: numel(File_CLAI15DE1)
%     CLAI15DE1  = geotiffread([File_CLAI15DE1(I_File).folder,'/',File_CLAI15DE1(I_File).name]);
%     
%     [LCT12YE1,R]= geotiffread([Path_LCT12YE1,'LCT_Mul_CMG5KM_USGS.tif']);
%     Proj        = geotiffinfo([Path_LCT12YE1,'LCT_Mul_CMG5KM_USGS.tif']);
%     
%     % processing phenology
%     LAImax = max(CLAI15DE1,[],3);
%     LAImin = min(CLAI15DE1,[],3);
%     LAIthr = (LAImax-LAImin)* 0.5 + LAImin;
%     
%     Date   = repmat(reshape(single(1:365),1,1,[]),size(CLAI15DE1,1),size(CLAI15DE1,2),1);
%     
%     % northern hemisphere
%     DateSPR=Date;
%     DateSPR(isnan(CLAI15DE1))=nan;
%     DateSPR(CLAI15DE1<LAIthr)=nan;
%     DateSPR=min(DateSPR,[],3);
%     
%     DateAUT=Date;
%     DateAUT(isnan(CLAI15DE1))=nan;
%     DateAUT(CLAI15DE1<LAIthr)=nan;
%     DateAUT=max(DateAUT,[],3);
%     
%     % mask
% %     DateSPR(LCT12YE1~=4)=nan;
% %     DateAUT(LCT12YE1~=4)=nan;
%     DateGSL=DateAUT-DateSPR;
%     
% %     % southern hemisphere
% %     DateSPR=Date;
% %     DateSPR(isnan(CLAI15DE1))=nan;
% %     DateSPR(CLAI15DE1>LAIthr)=nan;
% %     DateSPR=min(DateSPR,[],3);
% %     
% %     DateAUT=Date;
% %     DateAUT(isnan(CLAI15DE1))=nan;
% %     DateAUT(CLAI15DE1>LAIthr)=nan;
% %     DateAUT=max(DateAUT,[],3);
% %     
% %     % mask
% % %     DateSPR(LCT12YE1~=4)=nan;
% % %     DateAUT(LCT12YE1~=4)=nan;
% %     DateGSL=DateAUT-DateSPR;
%     
%     
%     % processing average
%     CLAI15YE1=mean(CLAI15DE1,3);
% 
%     % write data
%     FileName=regexprep(File_CLAI15DE1(I_File).name,'CLAI15DE1','LAI15YSPR');
%     geotiffwrite([Path_CLAI15YE1,FileName],DateSPR,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
%     
%     FileName=regexprep(File_CLAI15DE1(I_File).name,'CLAI15DE1','LAI15YAUT');
%     geotiffwrite([Path_CLAI15YE1,FileName],DateAUT,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
%     
%     FileName=regexprep(File_CLAI15DE1(I_File).name,'CLAI15DE1','LAI15YGSL');
%     geotiffwrite([Path_CLAI15YE1,FileName],DateGSL,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));    
%     
%     FileName=regexprep(File_CLAI15DE1(I_File).name,'CLAI15DE1','CLAI15YE1');
%     geotiffwrite([Path_CLAI15YE1,FileName],CLAI15YE1,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
%     disp(['Done with ',FileName]);
% end
