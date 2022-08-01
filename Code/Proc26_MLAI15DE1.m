clc; clear;

Path_LandCover = '../input/';
Path_LAI2TIF = '../output/12_LAI2TIF/';
Path_MOD15DLAI = '../output/26_MOD15DLAI/';

% system(['rm -rf ',Path_MOD15DLAI]);
% system(['mkdir -p ',Path_MOD15DLAI]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  %Landcover坐标
[Landcover,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);


for Year = 2011 
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
       
    MOD15DLAI = interp1(4.5:8:365,Yuan8SG,1:365,'linear','extrap');
    MOD15DLAI(MOD15DLAI < 0) = 0;

    clear Yuan8GF Yuan8HAM Yuan8SG

    MOD15DLAI = reshape(MOD15DLAI',3000,7200,[]);
    MOD15DLAI(Landcover==0 | Landcover==15 | Landcover==16)=nan;
    
    % round
    MOD15DLAI = round(MOD15DLAI,2);
    
    FileName=[Path_MOD15DLAI,'MOD15DLAI.A',YearName,'.tif'];
     geotiffwrite(FileName,MOD15DLAI,R,'GeoKeyDirectoryTag',...
     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

 disp(['Done with ',YearName]);
end