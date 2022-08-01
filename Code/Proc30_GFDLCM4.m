
addpath(genpath('./'));
clear; clc; 

Path_LAInc = '../input/CMIP6-LAI/';
Path_GFDLCM4 = '../output/30_GFDLCM4/';

system(['rm -rf ',Path_GFDLCM4]);
system(['mkdir -p ',Path_GFDLCM4]);

% parameter set 
Year = 1949;  % initialYear - 1
ModeName = 'GFDLCM4';
Spatial = '100km';
TimeSpan = 12;

 FileName = [Path_LAInc,'lai_Lmon_GFDL-CM4_hist-nat_r2i1p1f1_gr1_195001-201912.nc'];
 ncinf = ncinfo(FileName);
 Tempor = ncread(FileName,ncinf.Variables(2).Name);

 GeoLAI = double(rot90(Tempor)); 
 SizeInfo = size(GeoLAI);

 lat = double(ncread(FileName,ncinf.Variables(3).Name));
 lon = double(ncread(FileName,ncinf.Variables(5).Name));    

%    geotiff write
         
for Index = 1:TimeSpan:size(Tempor,3)
% for Index = 1:TimeSpan:12           
Year = Year + 1; 
YearName = num2str(Year,'%d');

MonLAI = GeoLAI(:,:,Index:min(12+Index-1,size(Tempor,3))); 
MonLAI = [MonLAI(:,145:end,:),MonLAI(:,1:144,:)];

R = georasterref('RasterSize',[size(MonLAI,1),size(MonLAI,2),size(MonLAI,3)],'Latlim',[min(lat),max(lat)],...
    'Lonlim',[-180+0.625,180-0.625]);
% %         R = georasterref('RasterSize',[size(MonLAI,1),size(MonLAI,2),size(MonLAI,3)],'Latlim',[-90,90],...
% %             'Lonlim',[-180,180]);
R.ColumnsStartFrom = 'north';
FileName =[Path_GFDLCM4,ModeName,'_LAI_',Spatial,'.A',YearName,'01-12.tif'];
geotiffwrite(FileName,MonLAI,R,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

disp(['Done with ',YearName]); 

end
