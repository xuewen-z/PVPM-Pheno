
clc; clear;
addpath(genpath('./'));

Path_LandCheck = '../input/LandCheck/';
% Path_GeoNPHN = '../output/07_GeoNPHN/';
Path_Geo2Site = '../output/17_Geo2Site/';
 
system(['rm -rf   ',Path_Geo2Site]);
system(['mkdir -p ',Path_Geo2Site]);

% study year

% for Year = 2001:2017
%     Year = 2005;
%     YearName = num2str(Year,'%d');


% phenology NAN
% FileList = dir([Path_GeoNPHN,'NAN*',YearName,'*.tif']);
% 
% for I_File = 1 : numel(FileList)
%     FileName = FileList(I_File).name;
%     [NAN12PHN,R] = geotiffread([Path_GeoNPHN,FileName]);
% end
% 
% NAN12PHN = (NAN12PHN < 50);

% Veg Seasonal cycles

% Geo12NUM = geotiffread([Path_GeoNPHN,'Geo12NUM.PHNNorh.',YearName,'.tif']);
% Geo12NUM = (Geo12NUM == 1);

% EV:ENF=1(146519);EBF=2(72509);
% DV:DNF=3(104091);DBF=4(30793);MIF=5(414940);
% SD:CSH=6(1795);OSH=7(624576);WSA=8(301042);SAV=9(90853);GRA=10(329697)


% PFT
LandType = geotiffread([Path_LandCheck,'LandENF_Mul_CMG005C_USGS.tif']);  % Landcover
LogicENF = (LandType > 0.95); 

LandType = geotiffread([Path_LandCheck,'LandEBF_Mul_CMG005C_USGS.tif']);  % Landcover
LogicEBF = (LandType > 0.95);

LandType = geotiffread([Path_LandCheck,'LandDNF_Mul_CMG005C_USGS.tif']);  % Landcover
LogicDNF = (LandType > 0.95);

LandType = geotiffread([Path_LandCheck,'LandDBF_Mul_CMG005C_USGS.tif']);  % Landcover
LogicDBF = (LandType > 0.95);

LandType = geotiffread([Path_LandCheck,'LandMIF_Mul_CMG005C_USGS.tif']);  % Landcover
LogicMIF = (LandType > 0.95); 

LandType = geotiffread([Path_LandCheck,'LandOSH_Mul_CMG005C_USGS.tif']);  % Landcover
LogicOSH = (LandType > 0.95); 

LandType = geotiffread([Path_LandCheck,'LandWSA_Mul_CMG005C_USGS.tif']);  % Landcover
LogicWSA = (LandType > 0.95); 

LandType = geotiffread([Path_LandCheck,'LandSAV_Mul_CMG005C_USGS.tif']);  % Landcover
LogicSAV= (LandType > 0.95);

LandType = geotiffread([Path_LandCheck,'LandGRA_Mul_CMG005C_USGS.tif']);  % Landcover
LogicGRA = (LandType > 0.95); 

IndexENF = find(LogicENF==1); 
IndexEBF = find(LogicEBF==1); 
IndexDNF = find(LogicDNF==1); 
IndexDBF = find(LogicDBF==1);
IndexMIF = find(LogicMIF==1);

IndexOSH = find(LogicOSH==1);
IndexWSA = find(LogicWSA==1); 
IndexSAV = find(LogicSAV==1);
IndexGRA = find(LogicGRA==1);
 
rand('seed',50);
RandENF = randperm(numel(IndexENF),4000); 

rand('seed',50);
RandEBF = randperm(numel(IndexEBF),4000);

rand('seed',50);
RandDNF = randperm(numel(IndexDNF),4000);

rand('seed',50);
RandDBF = randperm(numel(IndexDBF),4000);

rand('seed',50);
RandMIF = randperm(numel(IndexMIF),4000);  

rand('seed',50);
RandOSH = randperm(numel(IndexOSH),4000);  

rand('seed',50);
RandWSA = randperm(numel(IndexWSA),4000);

rand('seed',50);
RandSAV = randperm(numel(IndexSAV),4000);

rand('seed',50);
RandGRA = randperm(numel(IndexGRA),4000);


SiteInd = [IndexENF(RandENF);IndexEBF(RandEBF);IndexDNF(RandDNF);IndexDBF(RandDBF);IndexMIF(RandMIF);...
    IndexOSH(RandOSH);IndexWSA(RandWSA);IndexSAV(RandSAV);IndexGRA(RandGRA)];

SiteInd = SiteInd';
SiteCode = [1*ones(1,4000),2*ones(1,4000),3*ones(1,4000),4*ones(1,4000),5*ones(1,4000),...
    7*ones(1,4000),8*ones(1,4000),9*ones(1,4000),10*ones(1,4000);];

% write data
save([Path_Geo2Site,'Geo2Site.mat'],'-regexp','^Site*');


