% addpath(genpath('./'));
clear; clc; 

Path_DOY12YPHN = '../output/04_DOY12YPHN/';
Path_FUS12YPHN = '../output/05_FUS12YPHN/';
Path_PHNNorh = '../output/06_PHNNorh/';

% system(['rm -rf ',Path_PHNNorh]);
% system(['mkdir -p ',Path_PHNNorh]);


% geoinformation
[PHNGlobR,R] = geotiffread([Path_FUS12YPHN,'WGS12SPR.A2001001.006.tif']);  
Proj          = geotiffinfo([Path_FUS12YPHN,'WGS12SPR.A2001001.006.tif']);

[GridLon,GridLat]=pixcenters(Proj);
[LonMesh,LatMesh]=meshgrid(GridLon,GridLat);

[LatLeft,LonLeft]=pix2latlon(R,1,1);
[LatRight,LonRight]=pix2latlon(R,21600,86400);

LatLim = [LatRight LatLeft];
LonLim = [LonLeft LonRight]; 

[PHNNorhR,RN] = geocrop(PHNGlobR,R,LatLim,LonLim);


for I_Year= 2001: 2017
    YearName = num2str(I_Year,'%d');
    
    tic
    
%      SPRGlob = geotiffread([Path_FUS12YPHN,'WGS12SPR.A',YearName,'001.006.tif']);
%      SPRNorh = SPRGlob(1:21600,:);
%      
%      SUMGlob = geotiffread([Path_FUS12YPHN,'WGS12SUM.A',YearName,'001.006.tif']);
%      SUMNorh = SUMGlob(1:21600,:);
%      
%      AUTGlob = geotiffread([Path_FUS12YPHN,'WGS12AUT.A',YearName,'001.006.tif']);
%      AUTNorh = AUTGlob(1:21600,:);
     
%      WINGlob = geotiffread([Path_FUS12YPHN,'WGS12WIN.A',YearName,'001.006.tif']);
%      WINNorh = WINGlob(1:21600,:);

     NUMGlob = geotiffread([Path_DOY12YPHN,'WGS12NUM.A',YearName,'001.006.tif']);
     NUMNorh = NUMGlob(1:21600,:);
     
         % write data
%      FileName=['WGS12SPR.PHNNorh.',YearName,'.tif'];
%      geotiffwrite([Path_PHNNorh,FileName],SPRNorh,RN,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
%      FileName=['WGS12SUM.PHNNorh.',YearName,'.tif'];
%      geotiffwrite([Path_PHNNorh,FileName],SUMNorh,RN,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
%      FileName=['WGS12AUT.PHNNorh.',YearName,'.tif'];
%      geotiffwrite([Path_PHNNorh,FileName],AUTNorh,RN,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

%      FileName=['WGS12WIN.PHNNorh.',YearName,'.tif'];
%      geotiffwrite([Path_PHNNorh,FileName],WINNorh,RN,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

       FileName=['WGS12NUM.PHNNorh.',YearName,'.tif'];
       geotiffwrite([Path_PHNNorh,FileName],NUMNorh,RN,'GeoKeyDirectoryTag',...
          Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


    
     disp(['Done with ',YearName]); 

     toc
end
