
clc; clear;

addpath(genpath('./'));

Path_FluxData = '../output/40_FluxData/';
Path_FluxBdko = '../output/42_FluxBdko/';

system(['rm -rf   ', Path_FluxBdko]);
system(['mkdir -p ', Path_FluxBdko]);

% input data
load([Path_FluxData,'FluxData.mat']);

  
% Type = 'DBF' To Code = '4'; 
SiteCode=Type2Code(SiteType);
[Emax,Cgma,ParaA,ParaB,ParaC,ParaD] = ParamAlphaFlx(SiteCode);

MdlYLAI = Budyko2LAI(YRg,YPre,YAvgGSI,YTaRng,YElev,...
    Emax,Cgma,ParaA,ParaB,ParaC,ParaD);


MdlYLAI(MdlYLAI<0.01) = nan;
ObsYLAI = YLAI;

% LAImax
MdlLAImax = (MdlYLAI./ YGGSL).* 1.084;
ObsLAIm95 = YLAIm95;

save([Path_FluxBdko,'FluxMdlLAI.mat'],'-regexp','^Mdl*','^Obs*','^Site*');

