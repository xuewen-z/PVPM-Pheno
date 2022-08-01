
clc; clear;
Path_LandCover = '../input/';
Path_PHNNorh = '../output/06_PHNNorh/';
Path_GeoNPHN = '../output/07_GeoNPHN/';

% system(['rm -rf '  ,Path_GeoNPHN]);
% system(['mkdir -p ',Path_GeoNPHN]);

% geoinformation
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover
Proj          = geotiffinfo([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);

% [GridLon,GridLat]=pixcenters(Proj);
% [LonMesh,LatMesh]=meshgrid(GridLon,GridLat);


FileList = dir([Path_PHNNorh,'WGS12NUM*.tif']);

for I_File = 1 : numel(FileList)
    
    FUSNorPHN = geotiffread(fullfile(FileList(I_File).folder,FileList(I_File).name));

    % process
%     GeoNorPHN = imaggregation(FUSNorPHN,12,7); %phenology
    GeoNorPHN = imaggregation(FUSNorPHN,12,2); %number cycles
    GeoNorPHN = round(GeoNorPHN,0);
    
%     NANNorYPHN = imaggregation(double(isnan(FUSNorPHN)),12,8);
%     NANNorYPHN = round(NANNorYPHN/144 *100,0);
    
    % write data
    R.RasterSize = size(GeoNorPHN);
    
    FileName = regexprep(FileList(I_File).name,'WGS','Geo');
    geotiffwrite([Path_GeoNPHN,FileName],GeoNorPHN,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
%     FileName = regexprep(FileList(I_File).name,'WGS','NAN');
%     geotiffwrite([Path_GeoNPHN,FileName],NANNorYPHN,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
    disp(['Done with ',FileList(I_File).name]);
end
