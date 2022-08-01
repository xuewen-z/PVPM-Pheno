addpath(genpath('./'));

clc; clear;

Path_LandCover = '../input/';
Path_GlobGLDAS = '../input/GLDAS_NOAH005_DHalf_V02C/';
Path_AvgDGLDAS = '../output/14_AvgDGLDAS/';

system(['rm -rf '  ,Path_AvgDGLDAS]);
system(['mkdir -p ',Path_AvgDGLDAS]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

YearBgn = 2001;
YearEnd = 2010; 

tic

for Date = 1:365
%     Date = 1;
    DateName= num2str(Date,'%03d');

    system(['mkdir -p ',fullfile(Path_AvgDGLDAS,DateName)]);

    for Year = 2001:2010
        YearName=num2str(Year);
        
        % read data
        FileName = dir([Path_GlobGLDAS,YearName,'/*Shorad*',YearName,DateName,'*.tif']);
        DRg(:,:,Year-2000) = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Temmin*',YearName,DateName,'*.tif']);
        DTmn(:,:,Year-2000) = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Vapdef*',YearName,DateName,'*.tif']);
        DVPD(:,:,Year-2000) = geotiffread(fullfile(FileName.folder,FileName.name));                    

        FileName = dir([Path_GlobGLDAS,YearName,'/*Photop*',YearName,DateName,'*.tif']);
        DPho(:,:,Year-2000) = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Precip*',YearName,DateName,'*.tif']);
        DPre(:,:,Year-2000) = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Temavg*',YearName,DateName,'*.tif']);
        DTa(:,:,Year-2000) = geotiffread(fullfile(FileName.folder,FileName.name));
    end
    
    AvgDRg = mean(DRg,3);
    AvgDTmn = mean(DTmn,3);
    AvgDVPD = mean(DVPD,3);
    AvgDPho = mean(DPho,3);
    AvgDPre = mean(DPre,3);
    AvgDTa = mean(DTa,3);
    
    AvgDIGSI = Met2IGSI(AvgDPho,AvgDTmn,AvgDVPD);

    % write data
    BgnName = num2str(YearBgn,'%d');
    EndName = num2str(YearEnd,'%d');
    
    FileName=['AvgDRg.A',BgnName,EndName,'.',DateName,'.tif'];
    geotiffwrite(fullfile(Path_AvgDGLDAS,DateName,FileName),AvgDRg,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['AvgDTmn.A',BgnName,EndName,'.',DateName,'.tif'];
    geotiffwrite(fullfile(Path_AvgDGLDAS,DateName,FileName),AvgDTmn,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['AvgDVPD.A',BgnName,EndName,'.',DateName,'.tif'];
    geotiffwrite(fullfile(Path_AvgDGLDAS,DateName,FileName),AvgDVPD,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['AvgDPho.A',BgnName,EndName,'.',DateName,'.tif'];
    geotiffwrite(fullfile(Path_AvgDGLDAS,DateName,FileName),AvgDPho,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['AvgDPre.A',BgnName,EndName,'.',DateName,'.tif'];
    geotiffwrite(fullfile(Path_AvgDGLDAS,DateName,FileName),AvgDPre,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['AvgDTa.A',BgnName,EndName,'.',DateName,'.tif'];
    geotiffwrite(fullfile(Path_AvgDGLDAS,DateName,FileName),AvgDTa,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['AvgDIGSI.A',BgnName,EndName,'.',DateName,'.tif'];
    geotiffwrite(fullfile(Path_AvgDGLDAS,DateName,FileName),AvgDIGSI,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
    disp(['Done with ',DateName]); 
end

toc


