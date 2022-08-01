addpath(genpath('./'));

clc; clear;

Path_LandCover = '../input/';
Path_GlobGLDAS = '../input/GLDAS_NOAH005_DHalf_V02C/';
Path_GlobYGLDAS = '../output/22_GlobYGLDAS/';

% system(['rm -rf '  ,Path_GlobYGLDAS]);
% system(['mkdir -p ',Path_GlobYGLDAS]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

YearBgn = 2001;
YearEnd = 2017; 

tic


for Year = YearBgn:YearEnd
    YearName=num2str(Year);
        
%         system(['mkdir -p ',fullfile(Path_GlobYGLDAS,YearName)]);
     DIGSI = [];
     DRg = [];
     DPre = [];
     DTa = [];
     
        parfor Date = 1:365
               DateName= num2str(Date,'%03d');

        % read data
        FileName = dir([Path_GlobGLDAS,YearName,'/*Temmin*',YearName,DateName,'*.tif']);
        DTmn = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Vapdef*',YearName,DateName,'*.tif']);
        DVPD = geotiffread(fullfile(FileName.folder,FileName.name));                    

        FileName = dir([Path_GlobGLDAS,YearName,'/*Photop*',YearName,DateName,'*.tif']);
        DPho = geotiffread(fullfile(FileName.folder,FileName.name));

        DIGSI(Date,:,:) = Met2IGSI(DPho,DTmn,DVPD);

        disp(['Done with ',DateName]); 
        
        end
        
        % GSI-GSL  GSI-FGSI

        DIGSI = movavg(DIGSI,'simple',21);
        DIGSI = reshape(DIGSI,365,[]);

        GlobFGSI = mean(DIGSI,1);
        GlobFGSI = reshape(GlobFGSI,R.RasterSize);

        GlobYGGSL = sum((DIGSI-0.1)>0,1);
        GlobYGGSL = reshape(GlobYGGSL,R.RasterSize);
         
        
     
        parfor Date = 1:365
               DateName= num2str(Date,'%03d');
      
        FileName = dir([Path_GlobGLDAS,YearName,'/*Precip*',YearName,DateName,'*.tif']);
        DPre(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Shorad*',YearName,DateName,'*.tif']);
        DRg(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));
                
        FileName = dir([Path_GlobGLDAS,YearName,'/*Temavg*',YearName,DateName,'*.tif']);
        DTa(Date,:,:) = geotiffread(fullfile(FileName.folder,FileName.name));


        disp(['Done with ',DateName]); 
        
        end
        
        
        DRg = reshape(DRg,365,[]);
        GlobYRg = sum(DRg,1); 
        GlobYRg = reshape(GlobYRg,R.RasterSize);

               
        DPre = reshape(DPre,365,[]); 
        GlobYPre = sum(DPre,1);
        GlobYPre = reshape(GlobYPre,R.RasterSize);

     
        DTa = reshape(DTa,365,[]);
        GlobYTaRng = max(DTa,[],1) - min(DTa,[],1);
        GlobYTaRng = reshape(GlobYTaRng,R.RasterSize);

                     
    % write data   
   
    save([Path_GlobYGLDAS,'GlobData.A',YearName,'.mat'],'-regexp','^Glob*');
        
    disp(['Done with ',YearName]); 

end

toc

  
%     FileName=['GlobYGGSL.A',YearName,'.tif'];
%     geotiffwrite(fullfile(Path_GlobYGLDAS,YearName,FileName),GlobYGGSL,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
%     FileName=['GlobYRg.A',YearName,'.tif'];
%     geotiffwrite(fullfile(Path_GlobYGLDAS,YearName,FileName),GlobYRg,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
%     FileName=['GlobYPre.A',YearName,'.tif'];
%     geotiffwrite(fullfile(Path_GlobYGLDAS,YearName,FileName),GlobYPre,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
%     FileName=['GlobYTaRng.A',YearName,'.tif'];
%     geotiffwrite(fullfile(Path_GlobYGLDAS,YearName,FileName),GlobYTaRng,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


