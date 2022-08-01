clc; clear;

Path_LandCover = '../input/';
Path_LAI2TIF = '../output/12_LAI2TIF/';
Path_MODAvgFpar = '../output/25_MODAvgFpar/';

system(['rm -rf ',Path_MODAvgFpar]);
system(['mkdir -p ',Path_MODAvgFpar]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

YearBgn = 2001;
YearEnd = 2017; 

MODAvgFpar = nan([R.RasterSize]);

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


    TempDFpar = 1-exp(-0.5.* GlobDLAI);
    TempDFpar = reshape(TempDFpar',3000,7200,[]);
    MODAvgFpar = mean(TempDFpar,3); % AVG
    
 
    FileName=[Path_MODAvgFpar,'MODAvgFpar.A',YearName,'.tif'];
         geotiffwrite(FileName,MODAvgFpar,R,'GeoKeyDirectoryTag',...
         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
    disp(['Done with ',YearName]);
end



% FileName=[Path_MODLAIm95,'GlobGSL.A',BgnName,'.',EndName,'.tif'];
%      geotiffwrite(FileName,GlobGSL,R,'GeoKeyDirectoryTag',...
%      Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 

% 
% FileName=[Path_MODLAIm95,'GlobYLAI.A',BgnName,'.',EndName,'.tif'];
%      geotiffwrite(FileName,GlobYLAI,R,'GeoKeyDirectoryTag',...
%      Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
