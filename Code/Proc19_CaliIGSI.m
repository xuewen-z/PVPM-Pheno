

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

bl=[ 0.0,  0.0 , -20.0, -20.0, 0 , 0];  % 
bu=[ 24.0, 24.0,  20.0,  20.0, 5 , 5];  % 
x0=(bl+bu)/2;
FUNC=@(x) CalibArfa(x);

% SCEUA process (minimize the cost function)
[Bestx,Bestf] = sceua(FUNC,x0,bl,bu,maxn,kstop,pcento,peps,ngs,iseed,iniflg);

[~,YLAI,MYLAI]=CalibArfa(Bestx);
figure;plot(YLAI(:),MYLAI(:),'o')
refline([1 0])
R2  = rsquare(YLAI,MYLAI);
RMSE= rmse(YLAI,MYLAI);
AI  = agreeindex(YLAI,MYLAI);
disp(R2);disp(RMSE);disp(AI);

% disp(Type);

Index = 1;
figure;hold on;
plot(YLAI(:),'k');
plot(MYLAI(:),'b');


function [Cost,YLAI,MYLAI]=CalibArfa(Param)


a = Param(1);
b = Param(2);
c = Param(3);     	
d = Param(4);
e = Param(5);
f = Param(6);     	

    
Path_UniqData = '../output/41_UniqData/';
load([Path_UniqData,'UniqData.mat']);
% Path_SiteData = '../output/18_SiteData/';
% load([Path_SiteData,'SiteData.mat']);


IPho = (TepDPho-b)/(a-b);
IPho = min(max(0,IPho),1);

ITmn = (TepDTmn-c)/(d-c);
ITmn = min(max(0,ITmn),1);

IVPD = 1 - (TepDVPD-f)/(e-f);
IVPD = min(max(0,IVPD),1);


IGSI = IVPD .* ITmn .* IPho;

UniqAvgGSI = mean(IGSI,1);
MYLAI = UniqAvgGSI;
YLAI = UniqAvgFpar;


Cost = 1-agreeindex(YLAI(:),MYLAI(:));

end
