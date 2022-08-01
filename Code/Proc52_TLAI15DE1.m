clc; clear;
addpath(genpath('./'));

Path_LandCover = '../input/';
Path_GlobMLAIx = '../output/23_GlobMLAIx/';
Path_SLAI15DE1 = '../output/51_SLAI15DE1/';
Path_TLAI15DE1 = '../output/52_TLAI15DE1/';

system(['rm -rf '  ,Path_TLAI15DE1]);
system(['mkdir -p ',Path_TLAI15DE1]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[LCT12YE1,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

% % parameterization for GPP modeling
% [Emax,Tmnmin,Tmnmax,VPDmin,VPDmax]=ParamMOD17C(LCT12YE1);

for Year = 2001:2017
% for Year = 2002
    YearName=num2str(Year);
    
    SLAI15DE1 = nan(3000,7200,365);

   %     for Date = 365
    parfor Date = 1:365
        DateName= [YearName,num2str(Date,'%03d')];
        
        % read data
        File_SLAI15DE1= dir([Path_SLAI15DE1,YearName,'/*A',DateName,'*']);
        SLAI15DE1(:,:,Date)= geotiffread(fullfile(File_SLAI15DE1.folder,File_SLAI15DE1.name));
    end

       % Modeled maximum leaf area index
   TMAXYLAI = geotiffread([Path_GlobMLAIx,'MdlLAImax.A',YearName,'.tif']);
   TMAXYLAI = round(TMAXYLAI,2);
   
   TMAXYLAI = repmat(TMAXYLAI,1,1,365);
   SLAI15DE1(SLAI15DE1>TMAXYLAI)=TMAXYLAI(SLAI15DE1>TMAXYLAI);
   SLAI15DE1(isnan(TMAXYLAI))=nan;


    % parameterization for LAI modeling
    [~,kLeaf]= ParamSGPD(LCT12YE1);
    kLeaf    = repmat(kLeaf,1,1,365);
    
    % time-stepping LAI and GPP using MOD17
    TLAI15DE1 = SLAI2TLAI(SLAI15DE1,kLeaf,3);
    
    % round
    TLAI15DE1 = round(TLAI15DE1,2);

    % write data
    FileName=['TLAI15DE1.A',YearName,'.tif'];
    geotiffwrite(fullfile(Path_TLAI15DE1,FileName),TLAI15DE1,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    disp(['Done with ',FileName]);
end


