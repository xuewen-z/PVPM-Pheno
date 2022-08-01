clc; clear;

addpath(genpath('./'));

Path_TowerData = '../output/19_TowerData/';
Path_FluxData = '../output/40_FluxData/';

system(['rm -rf   ', Path_FluxData]);
system(['mkdir -p ', Path_FluxData]);

load([Path_TowerData,'TowerData.mat']);

% Type Limit
BiomeCode = {'ENF','DBF','MIF','CSH','OSH','WSA','SAV','GRA','EBF'};
I_Code=ismember(SiteType,BiomeCode);
SiteType(~I_Code) = [];
SiteName(~I_Code) = [];
SiteYear(~I_Code) = [];
SiteLat = DLat(1,I_Code); 
SiteLon = DLon(1,I_Code);
DElev = DElev(1,I_Code);

% Variables 
DLAI = DLAI(:,I_Code); 
DPrec = DPrec(:,I_Code);
DRg = DRg(:,I_Code);
DTa = DTa(:,I_Code);
DTmn = DTmn(:,I_Code);
DVPD = DVPD(:,I_Code);
DPho = DPho(:,I_Code);

%
DIGSI = Met2IGSI(DPho,DTmn,DVPD);
DGSI = movavg(DIGSI,'simple',21);
YAvgGSI = mean(DGSI,1);

YGGSL = sum((DGSI-0.1)>0,1);
YGGSL(YGGSL<50) =nan;

YLAIm95 = prctile(DLAI,95,1);
YLAI = sum(DLAI,1);
YPre = sum(DPrec,1);
YTa = sum(DTa,1);

% Yearly
DLAImin = min(DLAI,[],1);
DLAImax = max(DLAI,[],1);

DThres = 0.2 .*(DLAImax-DLAImin)+DLAImin;
YGSL = sum( (DLAI-DThres)>0, 1);
YGSL(YGSL == 0) = nan;
% YFunc1 = YLAIm95 .* YGSL;
YFunc1 = YLAI ./ YGSL;

DFpar = 1-exp(-0.5.* DLAI);
YRg = sum(DRg,1).* 0.0864; % conversation from W/m2 to MJ/m2
YAvgFpar = mean(DFpar,1);
YElev = DElev .* 0.001;
YTaRng = max(DTa) - min(DTa);


save([Path_FluxData,'FluxData.mat'],'-regexp','^Y*','^Site*');
