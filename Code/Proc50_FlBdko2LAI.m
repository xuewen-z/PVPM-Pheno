clc; clear;

addpath(genpath('./'));

Path_UniqData = '../output/41_UniqData/';
Path_UniqBdko = '../output/43_UniqBdko/';
Path_FlBdko2LAI = '../output/50_FlBdko2LAI/';

system(['rm -rf   ', Path_FlBdko2LAI]);
system(['mkdir -p ', Path_FlBdko2LAI]);

load([Path_UniqBdko,'UniqMdlLAI.mat']);
load([Path_UniqData,'UniqData.mat'])

% Type Limit
% BiomeCode = {'ENF','DBF','MIF','CSH','OSH','WSA','SAV','GRA','EBF'};
% I_Code=ismember(UniqType,BiomeCode);
% UniqType(~I_Code) = [];
% UniqName(~I_Code) = [];
% UniqYear(~I_Code) = [];
% UniqLat = UniqLat(1,I_Code); 
% UniqLon = UniqLon(1,I_Code);
% UniqYElev = UniqYElev(1,I_Code);

% Variables 
% DLAI = DLAI(:,I_Code); 
% DGPP = DGPP(:,I_Code); DGPP(DGPP<-100)=nan; 
% DPrec = DPrec(:,I_Code);
% DRg = DRg(:,I_Code);
% DTa = DTa(:,I_Code);
% DTmn = DTmn(:,I_Code);
% DVPD = DVPD(:,I_Code);
% DPho = DPho(:,I_Code);

% Type='CRO'; 
SiteCode=Type2Code(UniqType);
SiteCode=repmat(SiteCode,365,1);

% parameterization for GPP modeling
[Emax,Tmnmin,Tmnmax,VPDmin,VPDmax]=ParamMOD17C(SiteCode);

% parameterization for LAI modeling
[mRatio,kLeaf]=ParamSGPD(SiteCode);

% deriving maximum and minimum LAI from remote sensing data
MaxLAI = MdlUniLAImax;
MaxLAI = repmat(MaxLAI,365,1);
MinLAI = zeros(1,131);
MinLAI = repmat(MinLAI,365,1);

% analytical solution
SLAI = SGPD2SLAI(TepDRg,TepDTmn,TepDVPD,Emax,Tmnmin,Tmnmax,VPDmin,VPDmax,mRatio);
SLAI(SLAI>MaxLAI)=MaxLAI(SLAI>MaxLAI);
SLAI(SLAI<MinLAI)=MinLAI(SLAI<MinLAI);

% time-stepping LAI and GPP using MOD17
TLAI = SLAI2TLAI(SLAI,kLeaf,1);
DLAI = TepDLAI;

% % GPP from analytical solution
% FPAR = 1-exp(-0.5*TLAI);
% TGPP = MOD17GPP(FPAR,DRg,DTmn,DVPD,Emax,Tmnmin,Tmnmax,VPDmin,VPDmax);
% 
% % MOD17GPP
% DFPAR = 1 - exp(-0.5*DLAI);
% MGPP = MOD17GPP(DFPAR,DRg,DTmn,DVPD,Emax,Tmnmin,Tmnmax,VPDmin,VPDmax);

save([Path_FlBdko2LAI,'FlBdko2LAI.mat'],'-regexp','TLAI','DLAI','^Uniq*');


