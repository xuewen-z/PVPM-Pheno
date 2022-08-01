% Output
% Daily Extraterrestrial radiation (DRa)  (in W/m2)
% Daily sun hours (Pho)  (in hours) 

Path_Refer= '../input/';
Path_NOAH02D= '../input/GLDAS_NOAH025_DLAI/';

Year = 2017; % ping year

% Geoinformation
[~,R]= geotiffread([Path_Refer,'LCT_Mul_CMG025_USGS.tif']);
Proj = geotiffinfo([Path_Refer,'LCT_Mul_CMG025_USGS.tif']);

[GridLon,GridLat]=pixcenters(Proj);

% Ra and SZA
[LonMesh,LatMesh]=meshgrid(GridLon,GridLat);
[Extrad,Photop]=SradDayS(LatMesh,LonMesh,Year);

% for Year=2016
for Year=2016:2017

    YearName=num2str(Year,'%.0f');
    
%     system(['mkdir -p ',Path_FORA02D,YearName]);
    
%     for Date=1
    parfor Date=1:365
    
        DateName=num2str(Date,'%03d');
        
        % write
        FileName=['GLDAS_NOAH025_D.Photop.A',YearName,DateName,'.02C.tif'];
        geotiffwrite([Path_NOAH02D,YearName,'/',FileName],Photop(:,:,Date),R,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

        disp(['Done with ',YearName,'/',DateName]);        
    end
end

