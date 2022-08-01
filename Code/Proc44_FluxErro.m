
addpath(genpath('./'));
clc;clear;

Path_FluxBdko = '../output/42_FluxBdko/';
Path_FlBdko2LAI = '../output/50_FlBdko2LAI/';
Path_FluxErro = '../output/44_FluxErro/';

system(['rm -rf   ', Path_FluxErro]);
system(['mkdir -p ', Path_FluxErro]);


load([Path_FluxBdko,'FluxMdlLAI.mat']);
load([Path_FlBdko2LAI,'FlBdko2LAI.mat']);

DLAI(DLAI<0)=nan;
TLAI(TLAI<0)=nan;

UniqName=unique(SiteName);

UniqType=cell(size(UniqName));

UniqDLat=nan(size(UniqName));
UniqDLon=nan(size(UniqName));

LAIRMSE=nan(size(UniqName));
LAIBias=nan(size(UniqName));

LAIxRMSE=nan(size(UniqName));
LAIxBias=nan(size(UniqName));

for I_Uniq= 1:numel(UniqName)
% for I_Uniq=1   
    I_Site=strcmp(UniqName(I_Uniq),SiteName);
   
    %YLAI
    Xdata=TLAI(:,I_Site);
    Ydata=DLAI(:,I_Site);
    
    UniqDLat(I_Uniq)=median(SiteLat(1,I_Site));
    UniqDLon(I_Uniq)=median(SiteLon(1,I_Site));
    
    LAIRMSE(I_Uniq)=rmse(Ydata(:),Xdata(:));
    LAIBias(I_Uniq)=mbe(Ydata(:),Xdata(:));   
    
    UniqType(I_Uniq)=unique(SiteType(:,I_Site));
    
    
    % LAIx
    Xdata=MdlLAImax(:,I_Site);
    Ydata=ObsLAIm95(:,I_Site);
    
    UniqDLat(I_Uniq)=median(SiteLat(1,I_Site));
    UniqDLon(I_Uniq)=median(SiteLon(1,I_Site));
    
    LAIxRMSE(I_Uniq)=rmse(Ydata(:),Xdata(:));
    LAIxBias(I_Uniq)=mbe(Ydata(:),Xdata(:));   
    
    UniqType(I_Uniq)=unique(SiteType(:,I_Site));
    
   
end

save([Path_FluxErro,'FuncErro.mat'],'-regexp','Uniq*','^LAI*','^LAIx*');
