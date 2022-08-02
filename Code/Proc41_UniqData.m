
clc; clear;

addpath(genpath('./'));

Path_TowerData = '../output/19_TowerData/';
Path_UniqData = '../output/41_UniqData/';

system(['rm -rf   ', Path_UniqData]);
system(['mkdir -p ', Path_UniqData]);

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

%% Multi-year mean

% Unique Site

    UniqName=unique(SiteName);
 
for I_Uniq = 1: numel(UniqName)
    I_Site=strcmp(UniqName(I_Uniq),SiteName);

    TepLAI = DLAI(:,I_Site);
    TepRg = DRg(:,I_Site);
    TepPre = DPrec(:,I_Site);
    TepTmn = DTmn(:,I_Site);    
    TepTa = DTa(:,I_Site);    
    TepVPD = DVPD(:,I_Site); 
    TepPho = DPho(:,I_Site);    

    UniqLat(I_Uniq)=median(SiteLat(1,I_Site));
    UniqLon(I_Uniq)=median(SiteLon(1,I_Site));
    UniqType(I_Uniq)=unique(SiteType(:,I_Site));
    UniqElev(I_Uniq)=unique(DElev(1,I_Site));    

    TepYear = numel(TepLAI(1,:));
    UniqYearNums(:,I_Uniq) = TepYear;   

    TepDLAI(:,I_Uniq) = nanmean(TepLAI,2);
    TepDRg(:,I_Uniq) = nanmean(TepRg,2);
    TepDPre(:,I_Uniq) = nanmean(TepPre,2);
    TepDTmn(:,I_Uniq) = nanmean(TepTmn,2);
    TepDTa(:,I_Uniq) = nanmean(TepTa,2);
    TepDVPD(:,I_Uniq) = nanmean(TepVPD,2);
    TepDPho(:,I_Uniq) = nanmean(TepPho,2);

end

UniqYLAIm95 = prctile(TepDLAI,95,1);
UniqYLAI = sum(TepDLAI,1);
UniqYPre = sum(TepDPre,1);
UniqYTa = sum(TepDTa,1);
UniqYRg = sum(TepDRg,1).* 0.0864;

TepDFpar = 1-exp(-0.5.* TepDLAI);
UniqAvgFpar = nanmean(TepDFpar,1);
UniqYElev = UniqElev .* 0.001;
UniqYTaRng = max(TepDTa) - min(TepDTa);

% GSL
LAImin = min(TepDLAI,[],1);
LAImax = max(TepDLAI,[],1);

DThres = 0.2.*(LAImax-LAImin)+LAImin;
UniqYGSL = sum( (TepDLAI-DThres)>0, 1);
UniqYGSL(UniqYGSL == 0) = nan;
% UniqYFunc1 = UniqYLAIm95 .* UniqYGSL;

UniqYFunc1 = UniqYLAI ./ UniqYGSL;

% GSI-GSL
TepDIGSI = Met2IGSI(TepDPho,TepDTmn,TepDVPD);
TepDGSI = movavg(TepDIGSI,'simple',21);
UniqAvgGSI = nanmean(TepDGSI,1);

UniqYGGSL = sum((TepDGSI-0.1)>0,1);
UniqYGGSL(UniqYGGSL<0.05) = nan;

save([Path_UniqData,'UniqData.mat'],'-regexp','^Uniq*','^Tep*');

