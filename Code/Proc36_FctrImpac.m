

clc; clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_MODLAIm95 = '../output/21_MODLAIm95/'; 
Path_GlobYGLDAS = '../output/22_GlobYGLDAS/';
Path_GlobMLAIx = '../output/23_GlobMLAIx/'; 
Path_FctrImpac = '../output/36_FctrImpac/';
% Path_Figure    = '../figure/';


system(['rm -rf   ', Path_FctrImpac]);
system(['mkdir -p ', Path_FctrImpac]);

WorldShape=shaperead('../misc/WorldCountry/world_country_boundary.shp','UseGeoCoords', true);
[Landcover,~] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover坐标

YearBgn = 2001;
YearEnd = 2017; 


for Year = YearBgn:YearEnd
    YearName = num2str(Year,'%d');
    
%% read data
    MdlASLAI = geotiffread([Path_GlobMLAIx,'MdlYLAI.A',YearName,'.tif']);
    ObsASLAI = geotiffread([Path_MODLAIm95,'MODYLAI.A',YearName,'.tif']);

    load([Path_GlobYGLDAS,'GlobData.A',YearName,'.mat']);
    MdlYGSL = GlobYGGSL;
    ObsYGSL = geotiffread([Path_MODLAIm95,'MODYGSL.A',YearName,'.tif']);

    Invalid= (Landcover==12 | Landcover==14 | Landcover==0 | Landcover==15 | Landcover==16);
    MdlASLAI(Invalid)=nan;
    ObsASLAI(Invalid)=nan;
    MdlYGSL(Invalid)=nan;  MdlYGSL(MdlYGSL< 50)=nan;
    ObsYGSL(Invalid)=nan;

    TempMYLAI = nanmean(MdlASLAI(:));
    TempOYLAI = nanmean(ObsASLAI(:));
    TempMGSL = nanmean(MdlYGSL(:));
    TempOGSL = nanmean(ObsYGSL(:));
   
    TetdMYLAI = nanstd(MdlASLAI(:));
    TetdOYLAI = nanstd(ObsASLAI(:));
    TetdMYGSL = nanstd(MdlYGSL(:));
    TetdOYGSL = nanstd(ObsYGSL(:));
    
    MeanMYLAI(:,Year - 2000) = TempMYLAI;
    MeanOYLAI(:,Year - 2000) = TempOYLAI;
    MeanMYGSL(:,Year - 2000) = TempMGSL;
    MeanOYGSL(:,Year - 2000) = TempOGSL;
    

    StdMYLAI(:,Year - 2000) = TetdMYLAI;
    StdOYLAI(:,Year - 2000) = TetdOYLAI;
    StdMYGSL(:,Year - 2000) = TetdMYGSL;
    StdOYGSL(:,Year - 2000) = TetdOYGSL;

end

save([Path_FctrImpac,'FctrImpac.mat'],'-regexp','^Mean*','^Std*');

