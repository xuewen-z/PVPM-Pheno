
clc; clear;

addpath(genpath('./'));

Path_UniqData = '../output/41_UniqData/';
Path_UniqBdko = '../output/43_UniqBdko/';

system(['rm -rf   ', Path_UniqBdko]);
system(['mkdir -p ', Path_UniqBdko]);

% input data
load([Path_UniqData,'UniqData.mat']);

% Type = 'DBF' To Code = '4'; 
UniqCode=Type2Code(UniqType);
[Emax,Cgma,ParaA,ParaB,ParaC,ParaD] = ParamAlphaFlx(UniqCode);

MdlUniYLAI = Budyko2LAI(UniqYRg,UniqYPre,UniqAvgGSI,UniqYTaRng,UniqYElev,...
    Emax,Cgma,ParaA,ParaB,ParaC,ParaD);
 
% % output data
% AmI = UniqYRg .* Emax .* 0.95 .* 0.45; % MJ/m2/yr
% AmP = UniqYPre .* Cgma; 
% 
% % ParamMOD17
% % Alpha = 1.2444 .* UniqAvgFpar + 0.0046 .* UniqYTaRng -0.0025 .* UniqYElev -0.1929 ;
% Alpha = 1.0700.* UniqAvgFpar + 0.0054 .* UniqYTaRng -0.0084 .* UniqYElev -0.2108 ;
% Alpha(Alpha < 0) =0;
% 
% budyco Annual LAI
% MdlUniYLAI = (AmP .* AmI) ./ (AmP.^Alpha + AmI.^Alpha).^(1./Alpha);
% MdlUniYLAI(MdlUniYLAI<0.01) = nan;

ObsUniYLAI = UniqYLAI;

% LAImax
UniqYGGSL(UniqYGGSL< 50) = nan;
MdlUniLAImax = (MdlUniYLAI./ UniqYGGSL).* 1.084;
MdlUniLAImax(MdlUniLAImax>7) = 7 ;
ObsUniLAIm95 = UniqYLAIm95;

save([Path_UniqBdko,'UniqMdlLAI.mat'],'-regexp','^Mdl*','^Obs*','^Uniq*');


%% Theory Fig 
% Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
% set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;
% 
% XData = UniqYPre;
% YData = UniqYLAI;
% 
% plot(XData,YData,'o','MarkerSize',8,...
%         'MarkerFaceColor',[0.3880 0.3650 0.6470],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);
% hold on; 
% Cgma = 973/684; %LAI

% Ref = refline([Cgma  0]);
% set(Ref,'Color','r','LineWidth',3);
% set(gca,'xlim',[0 2000],'ylim',[0 3000],'xtick',0:500:2000,'Fontsize',22,'ytick',0:1000:3000,'Fontsize',22,'Fontname','Times New Roman'); 
% 
% xlabel('annual precipitation (mm yr^{-1})','FontWeight','bold','Fontsize',26,'Fontname','Times New Roman');
% ylabel('annual LAI (m^2 m^{-2} yr^{-1})','FontWeight','bold','Fontsize',26,'Fontname','Times New Roman');
% text('String',['k = ',num2str(Cgma,'%.2f')],...
%      'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',36,'Fontname','Times New Roman');
% 
% pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',28);  
% print(Fig,'-dtiff','-r300',[Path_Figure,'T.tif']);close(Fig);

 
% 
% YData = UniqYLAI ./ AmI;
% XData = AmP ./ AmI; 
% 
% Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesFontSize',22);
% set(gca,'Units','Pixels','Position',[135 135 620 620]);box on;hold on;
% 
% plot(XData(:),YData(:),'o','MarkerSize',8,...
%         'MarkerFaceColor',[0.3880 0.3650 0.6470],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);
% set(gca,'xlim',[0 6],'ylim',[0 1.2],'xtick',0:1:5,'Fontsize',22,'ytick',0:0.5:1.5,'Fontsize',22,'Fontname','Times New Roman'); 
% 
% xlabel('AmP/AmI','FontWeight','bold','Fontsize',26,'Fontname','Times New Roman');
% ylabel('Anunual LAI/AmI','FontWeight','bold','Fontsize',26,'Fontname','Times New Roman');
% 
% ELine = line([0 1],[0 1],'Color','r','LineWidth',3); % [Xstart Xend],[Ystart Yend]
% hold on; 
% WLine = line([1 6],[1 1],'Color','r','LineWidth',3);


