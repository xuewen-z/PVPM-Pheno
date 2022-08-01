
clc; clear;
addpath(genpath('./'));

% SCEUA Parameter
maxn=10000;
ngs=2;
kstop=10;
pcento=0.1;
peps=0.001;
iseed=1000;
iniflg=0;

%% Avg annual Model Parameter

bl=[ 0.0, 0.0 , -0.001,  -0.5];
bu=[ 3.0, 0.01, -0.01 ,   0.5];
x0=(bl+bu)/2;
FUNC=@(x) CalibArfa(x);

% SCEUA process (minimize the cost function)
[Bestx,Bestf] = sceua(FUNC,x0,bl,bu,maxn,kstop,pcento,peps,ngs,iseed,iniflg);

[~,SiteYLAI,MYLAI]=CalibArfa(Bestx);
figure;plot(SiteYLAI(:),MYLAI(:),'o')
refline([1 0])
R2  = rsquare(SiteYLAI,MYLAI);
RMSE= rmse(SiteYLAI,MYLAI);
AI  = agreeindex(SiteYLAI,MYLAI);
disp(R2);disp(RMSE);disp(AI);

% disp(Type);

Index = 1;
figure;hold on;
plot(SiteYLAI(:),'k');
plot(MYLAI(:),'b');


function [Cost,SiteYLAI,MdlYLAI]=CalibArfa(Param)


a = Param(1);
b = Param(2);

c = Param(3);     	
d = Param(4);       


Path_SiteData = '../output/18_SiteData/';
load([Path_SiteData,'SiteData.mat']);

% [1:4000];[4001:8000];[8001:12000];[12001:16000];[16001:20000];[20001:24000];[24001:28000];[28001:32000];[32001:36000]};

I_code = [8001:12000];
SiteElev = SiteElev(I_code);
SiteFpar = SiteFpar(I_code);
SiteFGSI = SiteFGSI(I_code);
SiteYPre = SiteYPre(I_code);
SiteYRg = SiteYRg(I_code);
SiteYLAI = SiteYLAI(I_code);
SiteYGGSL = SiteYGGSL(I_code);
SiteRngYTa = SiteRngYTa(I_code);
SiteLAIm95 = SiteLAIm95(I_code);
SiteCode = SiteCode(I_code);
SiteFunc1 = SiteFunc1(I_code);

% Cgma = 1221/612; %LAI  

[Emax,Cgma]=ParamAlpha(SiteCode);

AmI = SiteYRg .* Emax .* 0.95 .* 0.45; % MJ/m2/yr
AmP = SiteYPre .* Cgma; 

% modeling 
Alpha = a .* SiteFGSI + b .* SiteRngYTa +c .* SiteElev + d ;
MdlYLAI = (AmP .* AmI) ./ (AmP.^Alpha + AmI.^Alpha).^(1./Alpha);


Cost = 1-agreeindex(SiteYLAI(:),MdlYLAI(:));

end

