addpath(genpath('./'));

clc; clear;

Path_LandCover = '../input/';
Path_GeoLAIavg = '../output/13_GeoLAIavg/';
Path_AvgYGGSL = '../output/15_AvgYGGSL/';
Path_AvgYGLDAS = '../output/16_AvgYGLDAS/';
Path_Geo2Site = '../output/17_Geo2Site/';
Path_SiteData = '../output/18_SiteData/';

system(['rm -rf '  ,Path_SiteData]);
system(['mkdir -p ',Path_SiteData]);


% input data

load([Path_Geo2Site,'Geo2Site.mat']);

GeoElev = geotiffread([Path_LandCover,'Globe.DEM.CMG005C.tif']);
GeoElev = double(GeoElev) .* 0.001; % km

FileName= dir([Path_GeoLAIavg,'/GeoAvgFpar*']);  %
GeoAvgFpar = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_GeoLAIavg,'/GeoYLAI*']); 
GeoYLAI = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_GeoLAIavg,'/GeoGSL*']);
GeoGSL = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_GeoLAIavg,'/GeoLAIm95*']);
GeoLAIm95 = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_AvgYGGSL,'/AvgYGGSL*']);
GeoAvgYGGSL = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_AvgYGGSL,'/AvgFGSI*']);  %
GeoAvgFGSI = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_AvgYGLDAS,'/AvgYRg*']); % MJ/m2
GeoAvgYRg = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_AvgYGLDAS,'/RngYTa*']); % C
GeoRngYTa = geotiffread(fullfile(FileName.folder,FileName.name));

FileName= dir([Path_AvgYGLDAS,'/AvgYPre*']); %mm
GeoAvgYPre = geotiffread(fullfile(FileName.folder,FileName.name));

% GeoFunc1 = GeoLAIm95 .* GeoGSL;
GeoFunc1 = GeoYLAI ./ GeoGSL;

SiteFunc1 = GeoFunc1(SiteInd); 
SiteElev = GeoElev(SiteInd);
SiteFpar = GeoAvgFpar(SiteInd); 
SiteFGSI = GeoAvgFGSI(SiteInd); 
SiteFGSI(SiteFGSI==0)=nan;
SiteYLAI = GeoYLAI(SiteInd); 
SiteLAIm95 = GeoLAIm95(SiteInd); 
SiteYGGSL = GeoAvgYGGSL(SiteInd); 
SiteYRg = GeoAvgYRg(SiteInd); 
SiteRngYTa = GeoRngYTa(SiteInd); 
SiteYPre = GeoAvgYPre(SiteInd); 

save([Path_SiteData,'SiteData.mat'],'-regexp','^Site*');
save([Path_SiteData,'GlobData.mat'],'-regexp','^Geo*');