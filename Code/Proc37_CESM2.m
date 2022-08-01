
addpath(genpath('./'));
clear; clc; 

Path_LAInc = '../input/CMIP6-LAI/';
Path_CESM2 = '../output/37_CESM2/';

system(['rm -rf ',Path_CESM2]);
system(['mkdir -p ',Path_CESM2]);

% parameter set 
Year = 1950 - 1;  % initialYear - 1
ModeName = 'CESM2';
Spatial = '100km';
TimeSpan = 12;

     FileName = [Path_LAInc,'lai_Lmon_CESM2_amip_r1i1p1f1_gn_195001-201412.nc'];
     ncinf = ncinfo(FileName);
     Tempor = ncread(FileName,ncinf.Variables(1).Name);

     GeoLAI = double(rot90(Tempor)); 
     SizeInfo = size(GeoLAI);
     
     lat = double(ncread(FileName,ncinf.Variables(2).Name));
     lon = double(ncread(FileName,ncinf.Variables(3).Name));    
    
%    geotiff write
         
       for Index = 1:TimeSpan:size(Tempor,3)
            Year = Year + 1; 
            YearName = num2str(Year,'%d');

            MonLAI = GeoLAI(:,:,Index:min(12+Index-1,size(Tempor,3))); 
            MonLAI = [MonLAI(:,145:end,:),MonLAI(:,1:144,:)];
            
            R = georasterref('RasterSize',[size(MonLAI,1),size(MonLAI,2),size(MonLAI,3)],'Latlim',[min(lat),max(lat)],...
                'Lonlim',[-180+0.625,180-0.625]);
        R.ColumnsStartFrom = 'north';
        FileName =[Path_CESM2,ModeName,'_LAI_',Spatial,'.A',YearName,'.tif'];
        geotiffwrite(FileName,MonLAI,R,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

        disp(['Done with ',YearName]); 
    
end
