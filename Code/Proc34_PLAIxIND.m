clc;clear;
addpath(genpath('./'));

Path_LandCover = '../input/';
Path_MODLAIm95 = '../output/21_MODLAIm95/';
Path_PLAIm95 = '../output/33_PLAIm95/';
Path_PLAIxIND = '../output/34_PLAIxIND/'; 

% system(['rm -rf   ',Path_PLAIxIND]);
% system(['mkdir -p ',Path_PLAIxIND]);


% 1) read data for CNNPHN
RefeName=[Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']; 
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);


% for Year = 2001 : 2017
    Year = 2008;
    YearName = num2str(Year);

    % read data
    PLAImax = geotiffread([Path_PLAIm95,'PLAIm95.A',YearName,'.tif']);
%    PLAImax = geotiffread([Path_PLAIm95,'CELAIm95.A',YearName,'.tif']);
    ObsLAIm95 = geotiffread([Path_MODLAIm95,'MODLAIm95.A',YearName,'.tif']);
        
    PLAIxNSE = nse3d(ObsLAIm95,PLAImax);
    PLAIxNSE(PLAIxNSE<0) = 0;
    PLAIxRMSE = rmse3d(ObsLAIm95,PLAImax); 
    PLAIxBIAS = mbe3d(ObsLAIm95,PLAImax);

   % write data
   FileName=['PLAIxNSE.',YearName,'.tif'];
    geotiffwrite([Path_PLAIxIND,FileName],PLAIxNSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate)); 
   FileName=['PLAIxRMSE.',YearName,'.tif'];
    geotiffwrite([Path_PLAIxIND,FileName],PLAIxRMSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
   FileName=['PLAIxBIAS.',YearName,'.tif'];
    geotiffwrite([Path_PLAIxIND,FileName],PLAIxBIAS,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    
%     OLAIxIND(:,:,Year - 2000) = ObsLAIm95;
%     MLAIxIND(:,:,Year - 2000) = PLAImax;

    disp(['Done with ',FileName]);

% end
    
    % 2) processing average
    
%     Obs15xAVG = nanmean(OLAIxIND,3);        
%     Mdl15xAVG = nanmean(MLAIxIND,3);
% 
% 
%     % write data
%     FileName=['Obs15xAVG.2001.2017.tif'];
%     geotiffwrite([Path_PLAIxIND,FileName],Obs15xAVG,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
%     FileName=['Mdl15xAVG.2001.2017.tif'];
%     geotiffwrite([Path_PLAIxIND,FileName],Mdl15xAVG,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% 
%  % 3)processing statistics Evaluate Index 
%    
%  %% obs-mdl
%     
%     PLAIxNSE = nse3d(Obs15xAVG,Mdl15xAVG);
%     PLAIxNSE(PLAIxNSE<0) = 0;
%     PLAIxRMSE = rmse3d(Obs15xAVG,Mdl15xAVG); 
%     PLAIxBIAS = mbe3d(Obs15xAVG,Mdl15xAVG);
%     
%     
%     % write data
%    FileName=['MLAIxNSE.2001.2017.tif'];
%     geotiffwrite([Path_PLAIxIND,FileName],PLAIxNSE,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate)); 
%    FileName=['MLAIxRMSE.2001.2017.tif'];
%     geotiffwrite([Path_PLAIxIND,FileName],PLAIxRMSE,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
%    FileName=['MLAIxBIAS.2001.2017.tif'];
%     geotiffwrite([Path_PLAIxIND,FileName],PLAIxBIAS,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
%     
