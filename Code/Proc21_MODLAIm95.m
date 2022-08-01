clc; clear;

Path_LandCover = '../input/';
Path_LAI2TIF = '../output/12_LAI2TIF/';
Path_MODLAIm95 = '../output/21_MODLAIm95/';

% system(['rm -rf ',Path_MODLAIm95]);
% system(['mkdir -p ',Path_MODLAIm95]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

YearBgn = 2001;
YearEnd = 2017; 

% MODYLAI = nan([R.RasterSize,YearEnd-YearBgn+1]);
% MODYGSL = nan([R.RasterSize,YearEnd-YearBgn+1]); 
% MODLAIm95 = nan([R.RasterSize,YearEnd-YearBgn+1]);

for Year = YearBgn:YearEnd
    YearName = num2str(Year,'%d');
    
    Yuan8DLAI = geotiffread([Path_LAI2TIF,'MODYuan.LAID08.005.',YearName,'.tif']);
    Yuan8DLAI = Yuan8DLAI(1:3000,:,:);
    Yuan8DLAI = reshape(Yuan8DLAI,[],46);
    
    % fill gap
    Yuan8GF = fillgaps(Yuan8DLAI,3);

    % remove spike
    Yuan8HAM = hampel(Yuan8GF);
    Yuan8HAM = hampel(Yuan8HAM);
    
    % savitzky-golay filter
    Yuan8SG = sgolayfilt(Yuan8HAM,3,7);
        
    Yuan8SG = permute(Yuan8SG,[2,1]);
       
    MODDLAI = interp1(4.5:8:365,Yuan8SG,1:365,'linear','extrap');
    MODDLAI(MODDLAI < 0) = 0;

    clear Yuan8GF Yuan8HAM Yuan8SG

    % GSL
    DLAImin = min(MODDLAI,[],1);
    DLAImax = max(MODDLAI,[],1);

    DThres = 0.2 .*(DLAImax-DLAImin)+DLAImin;
    MODYGSL = sum( (MODDLAI-DThres)>0, 1);
    MODYGSL(MODYGSL == 0) = nan;
    MODYGSL = reshape(MODYGSL,R.RasterSize);

%     TempLAIm95 = prctile(MODDLAI,95,1);
%     MODLAIm95 = reshape(TempLAIm95,R.RasterSize);

    MODDLAI = reshape(MODDLAI',3000,7200,[]);
%     MODDFpar = 1-exp(-0.5.* MODDLAI);
    
    MODYLAI = sum(MODDLAI,3);
%     TempAvgFpar = mean(MODDFpar,3);

%         FileName = [Path_MODLAIm95,'MODLAIm95.A',YearName,'.tif'];
%         geotiffwrite(FileName,MODLAIm95,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

        FileName=[Path_MODLAIm95,'MODYGSL.A',YearName,'.tif'];
        geotiffwrite(FileName,MODYGSL,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


        FileName=[Path_MODLAIm95,'MODYLAI.A',YearName,'.tif'];
        geotiffwrite(FileName,MODYLAI,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    disp(['Done with ',YearName]);
end




% FileName=[Path_MODLAIm95,'GlobAvgFpar.A',BgnName,'.',EndName,'.tif'];
%      geotiffwrite(FileName,GlobAvgFpar,R,'GeoKeyDirectoryTag',...
%      Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
