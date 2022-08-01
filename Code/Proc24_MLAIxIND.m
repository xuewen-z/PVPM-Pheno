clc;clear;
addpath(genpath('./'));

Path_LandCover = '../input/';
Path_MODLAIm95 = '../output/21_MODLAIm95/';
Path_GlobMLAIx = '../output/23_GlobMLAIx/';
Path_MLAIxIND = '../output/24_MLAIxIND/'; 

system(['rm -rf   ',Path_MLAIxIND]);
system(['mkdir -p ',Path_MLAIxIND]);


% 1) read data for CNNPHN
RefeName=[Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']; 
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);


for Year = 2001 : 2017
    YearName = num2str(Year);

    % read data
    MdlLAImax = geotiffread([Path_GlobMLAIx,'MdlLAImax.A',YearName,'.tif']);
    ObsLAIm95 = geotiffread([Path_MODLAIm95,'MODLAIm95.A',YearName,'.tif']);
        
    MLAIxNSE = nse3d(ObsLAIm95,MdlLAImax);
    MLAIxNSE(MLAIxNSE<0) = 0;
    MLAIxRMSE = rmse3d(ObsLAIm95,MdlLAImax); 
    MLAIxBIAS = mbe3d(ObsLAIm95,MdlLAImax);

   % write data
   FileName=['MLAIxNSE.',YearName,'.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],MLAIxNSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate)); 
   FileName=['MLAIxRMSE.',YearName,'.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],MLAIxRMSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
   FileName=['MLAIxBIAS.',YearName,'.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],MLAIxBIAS,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    
    OLAIxIND(:,:,Year - 2000) = ObsLAIm95;
    MLAIxIND(:,:,Year - 2000) = MdlLAImax;

    disp(['Done with ',FileName]);

end
    
    % 2) processing average
    
    Obs15xAVG = nanmean(OLAIxIND,3);        
    Mdl15xAVG = nanmean(MLAIxIND,3);


    % write data
    FileName=['Obs15xAVG.2001.2017.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],Obs15xAVG,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['Mdl15xAVG.2001.2017.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],Mdl15xAVG,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


 % 3)processing statistics Evaluate Index 
   
 %% obs-mdl
    
    MLAIxNSE = nse3d(Obs15xAVG,Mdl15xAVG);
    MLAIxNSE(MLAIxNSE<0) = 0;
    MLAIxRMSE = rmse3d(Obs15xAVG,Mdl15xAVG); 
    MLAIxBIAS = mbe3d(Obs15xAVG,Mdl15xAVG);
    
    
    % write data
   FileName=['MLAIxNSE.2001.2017.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],MLAIxNSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate)); 
   FileName=['MLAIxRMSE.2001.2017.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],MLAIxRMSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
   FileName=['MLAIxBIAS.2001.2017.tif'];
    geotiffwrite([Path_MLAIxIND,FileName],MLAIxBIAS,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
