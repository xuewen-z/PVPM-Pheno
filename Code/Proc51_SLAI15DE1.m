clc; clear

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_GlobGLDAS = '../input/GLDAS_NOAH005_DHalf_V02C/';
Path_SLAI15DE1 = '../output/51_SLAI15DE1/';

% system(['rm -rf '  ,Path_SLAI15DE1]);
% system(['mkdir -p ',Path_SLAI15DE1]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[LCT12YE1,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);


% parameterization for GPP modeling
[Emax,Tmnmin,Tmnmax,VPDmin,VPDmax]=ParamMOD17C(LCT12YE1);

% parameterization for LAI modeling
[mRatio,kLeaf]=ParamSGPD(LCT12YE1);

for Year = 2001:2017
% for Year = 1982
    YearName=num2str(Year);
    
    system(['mkdir -p ',fullfile(Path_SLAI15DE1,YearName)]);
    
%     for Date = 220
    parfor Date = 1:365
           DateName= num2str(Date,'%03d');
        
        % read data
        FileName = dir([Path_GlobGLDAS,YearName,'/*Shorad*',YearName,DateName,'*.tif']);
        DRg = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Temmin*',YearName,DateName,'*.tif']);
        DTmn = geotiffread(fullfile(FileName.folder,FileName.name));

        FileName = dir([Path_GlobGLDAS,YearName,'/*Vapdef*',YearName,DateName,'*.tif']);
        DVPD = geotiffread(fullfile(FileName.folder,FileName.name));                    
        
               
        DRg=DRg * 10^6 / 3600 / 24; % from MJ/m2/d to W/m2
        
        % process
        SLAI = SGPD2SLAI(DRg,DTmn,DVPD,Emax,Tmnmin,Tmnmax,VPDmin,VPDmax,mRatio);
        
        % round
        SLAI = round(SLAI,2);

        % write data
        FileName=['SLAI15DE1.A',YearName,num2str(Date,'%03d'),'.tif'];
        geotiffwrite(fullfile(Path_SLAI15DE1,YearName,FileName),SLAI,R,'GeoKeyDirectoryTag',...
            Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

        disp(['Done with ',FileName]);
    end
end
