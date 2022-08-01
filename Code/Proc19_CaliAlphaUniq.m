

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

[~,UniqYLAI,MdlYLAI]=CalibArfa(Bestx);
figure;plot(UniqYLAI(:),MdlYLAI(:),'o')
refline([1 0])
R2  = rsquare(UniqYLAI,MdlYLAI);
RMSE= rmse(UniqYLAI,MdlYLAI);
AI  = agreeindex(UniqYLAI,MdlYLAI);
disp(R2);disp(RMSE);disp(AI);

% disp(Type);

Index = 1;
figure;hold on;
plot(UniqYLAI(:),'k');
plot(MdlYLAI(:),'b');


function [Cost,UniqYLAI,MdlYLAI]=CalibArfa(Param)


a = Param(1);
b = Param(2);

c = Param(3);     	
d = Param(4);       
   
    
Path_UniqData = '../output/41_UniqData/';
load([Path_UniqData,'UniqData.mat']);


BiomeCode = {'GRA'};
%'ENF','EBF','DBF','MIF','CSH','OSH','WSA','SAV','GRA'
I_code=ismember(UniqType,BiomeCode);

UniqCode = Type2Code(BiomeCode);
UniqYElev = UniqYElev(I_code);
% UniqAvgFpar = UniqAvgFpar(I_code);
UniqAvgGSI = UniqAvgGSI(I_code);
UniqYPre = UniqYPre(I_code);
UniqYRg = UniqYRg(I_code);
UniqYLAI = UniqYLAI(I_code);
UniqYGGSL = UniqYGGSL(I_code);
UniqYGSL = UniqYGSL(I_code);
UniqYTaRng = UniqYTaRng(I_code);
UniqYLAIm95 = UniqYLAIm95(I_code);
UniqYFunc1 = UniqYFunc1(I_code);

[Emax,Cgma]=ParamAlphaFlx(UniqCode);


AmI = UniqYRg .* Emax .* 0.95 .* 0.45; % MJ/m2/yr
AmP = UniqYPre .* Cgma; 

% modeling 
Arfa = a .* UniqAvgGSI + b .* UniqYTaRng +c .* UniqYElev + d ;
MdlYLAI = (AmP .* AmI) ./ (AmP.^Arfa + AmI.^Arfa).^(1./Arfa);


Cost = 1-agreeindex(UniqYLAI(:),MdlYLAI(:));

end