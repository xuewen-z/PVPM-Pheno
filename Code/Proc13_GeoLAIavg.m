clc; clear;

Path_LandCover = '../input/';
Path_LAI2TIF = '../output/12_LAI2TIF/';
Path_GeoLAIavg = '../output/13_GeoLAIavg/';

system(['rm -rf ',Path_GeoLAIavg]);
system(['mkdir -p ',Path_GeoLAIavg]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

YearBgn = 2001;
YearEnd = 2010; 

GlobYLAI = nan([R.RasterSize,YearEnd-YearBgn+1]);
GlobAvgFpar = nan([R.RasterSize,YearEnd-YearBgn+1]);
GlobGSL = nan([R.RasterSize,YearEnd-YearBgn+1]); 
GlobLAIm95 = nan([R.RasterSize,YearEnd-YearBgn+1]);

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
       
    GlobDLAI = interp1(4.5:8:365,Yuan8SG,1:365,'linear','extrap');
    GlobDLAI(GlobDLAI < 0) = 0;

    clear Yuan8GF Yuan8HAM Yuan8SG

    % GSL
    DLAImin = min(GlobDLAI,[],1);
    DLAImax = max(GlobDLAI,[],1);

    DThres = 0.2 .*(DLAImax-DLAImin)+DLAImin;
    TempGSL = sum( (GlobDLAI-DThres)>0, 1);
    TempGSL(TempGSL == 0) = nan;
    TempGSL = reshape(TempGSL,R.RasterSize);

    TempLAIm95 = prctile(GlobDLAI,95,1);
    TempLAIm95 = reshape(TempLAIm95,R.RasterSize);

    GlobDLAI = reshape(GlobDLAI',3000,7200,[]);
    GlobDFpar = 1-exp(-0.5.* GlobDLAI);
    
    TempYLAI = sum(GlobDLAI,3);
    TempAvgFpar = mean(GlobDFpar,3);
    
    GlobYLAI(:,:,Year-2000) = TempYLAI;
    GlobAvgFpar(:,:,Year-2000) = TempAvgFpar;
    GlobGSL(:,:,Year-2000) = TempGSL;
    GlobLAIm95(:,:,Year-2000) = TempLAIm95;
    
    disp(['Done with ',YearName]);
end

GlobYLAI = mean(GlobYLAI,3);
GlobAvgFpar = mean(GlobAvgFpar,3);
GlobGSL = mean(GlobGSL,3);
GlobLAIm95 = mean(GlobLAIm95,3);


BgnName = num2str(YearBgn,'%d');
EndName = num2str(YearEnd,'%d');

FileName=[Path_GeoLAIavg,'GlobGSL.A',BgnName,'.',EndName,'.tif'];
     geotiffwrite(FileName,GlobGSL,R,'GeoKeyDirectoryTag',...
     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=[Path_GeoLAIavg,'GlobLAIm95.A',BgnName,'.',EndName,'.tif'];
     geotiffwrite(FileName,GlobLAIm95,R,'GeoKeyDirectoryTag',...
     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=[Path_GeoLAIavg,'GlobYLAI.A',BgnName,'.',EndName,'.tif'];
     geotiffwrite(FileName,GlobYLAI,R,'GeoKeyDirectoryTag',...
     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=[Path_GeoLAIavg,'GlobAvgFpar.A',BgnName,'.',EndName,'.tif'];
     geotiffwrite(FileName,GlobAvgFpar,R,'GeoKeyDirectoryTag',...
     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
