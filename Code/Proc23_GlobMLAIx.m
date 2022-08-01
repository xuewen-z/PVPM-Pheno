
clc; clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
% Path_GeoLAIavg = '../output/13_GeoLAIavg/';
% Path_AvgYGGSL = '../output/15_AvgYGGSL/';
Path_GlobYGLDAS = '../output/22_GlobYGLDAS/';
Path_GlobMLAIx = '../output/23_GlobMLAIx/';

% system(['rm -rf   ', Path_GlobMLAIx]);
% system(['mkdir -p ', Path_GlobMLAIx]);

RefeName = [Path_LandCover,'LCT_Mul_CMG005C_USGS.tif'];  
[GeoCode,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

% GeoAvgFpar = geotiffread([Path_GeoLAIavg,'GeoAvgFpar.A2001.2010.tif']);
% GeoAvgFGSI = geotiffread([Path_AvgYGGSL,'AvgFGSI.A2001.2010.001.tif']);

GeoElev = geotiffread([Path_LandCover,'Globe.DEM.CMG005C.tif']);
GeoElev = double(GeoElev) .* 0.001; % km

for Year = 2001:2017
YearName = num2str(Year);

% input data
load([Path_GlobYGLDAS,'GlobData.A',YearName,'.mat']);


% Type = 'DBF' To Code = '4'; 
% GeoCode=Type2Code(GeoType);
[Emax,Cgma,ParaA,ParaB,ParaC,ParaD,ParaS]=ParamAlpha(GeoCode);

% ASLAI
MdlYLAI = Budyko2LAI(GlobYRg,GlobYPre,GlobFGSI,GlobYTaRng,GeoElev,...
    Emax,Cgma,ParaA,ParaB,ParaC,ParaD);

% LAImax

% GlobYGGSL(GlobYGGSL < 50) = nan;
% MdlLAImax = (MdlYLAI./ GlobYGGSL).* ParaS; % 1.123
% MdlLAImax(MdlLAImax>7)=7;

% FileName=[Path_GlobMLAIx,'MdlLAImax.A',YearName,'.tif'];
%     geotiffwrite(FileName,MdlLAImax,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

FileName=[Path_GlobMLAIx,'MdlYLAI.A',YearName,'.tif'];
    geotiffwrite(FileName,MdlYLAI,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    disp(['Done with ',YearName]); 

end