
addpath(genpath('./'));
clear; clc; 

Path_LAINC = '../input/MODYuan_LAID08_005/';
Path_LAI2TIF = '../output/12_LAI2TIF/';

system(['rm -rf ',Path_LAI2TIF]);
system(['mkdir -p ',Path_LAI2TIF]);

for  I_Year= 2000: 2019
     YearName = num2str(I_Year,'%d');
    
     FileName = [Path_LAINC,'lai_8-day_0.05_',YearName,'.nc'];
     ncinf = ncinfo(FileName);
     Tempor = ncread(FileName,ncinf.Variables(4).Name);

     LAIGlob=double(rot90(Tempor)); 
     LAIGlob=flipud(LAIGlob);
%      LAI_Yuan_D08005_USGS = LAIGlob(:,:,30);
     SizeInfo = size(LAIGlob);
     
     Lon = double(ncread(FileName,ncinf.Variables(1).Name));
     Lat = double(ncread(FileName,ncinf.Variables(2).Name));

%    geotiff write

    R = georasterref('RasterSize',SizeInfo,'Latlim',[min(Lat),max(Lat)],...
        'Lonlim',[min(Lon),max(Lon)]);
    R.ColumnsStartFrom = 'north';
    FileName =[Path_LAI2TIF,'MODYuan.LAID08.005.',YearName,'.tif'];
    geotiffwrite(FileName,LAIGlob,R,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
%     FileName =[Path_LAI2TIF,'LAI_Yuan_D08005_USGS.tif'];
%     geotiffwrite(FileName,LAI_Yuan_D08005_USGS,R,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    disp(['Done with ',YearName]); 
    
end


