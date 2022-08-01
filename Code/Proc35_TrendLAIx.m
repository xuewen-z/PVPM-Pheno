

clc; clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_MODLAIm95 = '../output/21_MODLAIm95/'; 
Path_GlobMLAIx = '../output/23_GlobMLAIx/'; 
Path_PLAIm95 = '../output/33_PLAIm95/';
Path_TrendLAIx = '../output/35_TrendLAIx/';
% Path_Figure    = '../figure/';


% system(['rm -rf   ', Path_TrendLAIx]);
% system(['mkdir -p ', Path_TrendLAIx]);

WorldShape=shaperead('../misc/WorldCountry/world_country_boundary.shp','UseGeoCoords', true);
[Landcover,~] = geotiffread([Path_LandCover,'LCT_Mul_CMG005C_USGS.tif']);  % Landcover坐标

YearBgn = 2001;
YearEnd = 2014; 


for Year = YearBgn:YearEnd
    YearName = num2str(Year,'%d');
    
%% read data
%     MdlLAImax = geotiffread([Path_GlobMLAIx,'MdlLAImax.A',YearName,'.tif']);
%     ObsLAIm95 = geotiffread([Path_MODLAIm95,'MODLAIm95.A',YearName,'.tif']);
%     CipLAIm95 = geotiffread([Path_PLAIm95,'PLAIm95.A',YearName,'.tif']);
    CipLAIm95 = geotiffread([Path_PLAIm95,'CELAIm95.A',YearName,'.tif']);

    Invalid= (Landcover==12 | Landcover==14 | Landcover==0 | Landcover==15 | Landcover==16);
%     MdlLAImax(Invalid)=nan;
%     ObsLAIm95(Invalid)=nan;
    CipLAIm95(Invalid)=nan;
% 
%     TempMLAI = nanmean(MdlLAImax(:));
%     TempOLAI = nanmean(ObsLAIm95(:));
    TempCLAI = nanmean(CipLAIm95(:));
%         
%     TetdMLAI = nanstd(MdlLAImax(:));
%     TetdOLAI = nanstd(ObsLAIm95(:));
    TetdCLAI = nanstd(CipLAIm95(:));

    
%     m=MdlLAImax(1:1800,:);
%     o=ObsLAIm95(1:1800,:);
    c=CipLAIm95(1:1800,:);
    
%     TempMLAIn = nanmean(m(:));
%     TempOLAIn = nanmean(o(:));
    TempCLAIn = nanmean(c(:));

%     TetdMLAIn = nanstd(m(:));
%     TetdOLAIn = nanstd(o(:));
    TetdCLAIn = nanstd(c(:));
% 
%     
%     m=MdlLAImax(1801:3000,:);
%     o=ObsLAIm95(1801:3000,:);
    c=CipLAIm95(1801:3000,:);

%     TempMLAIs = nanmean(m(:));
%     TempOLAIs = nanmean(o(:));
    TempCLAIs = nanmean(c(:));

%     TetdMLAIs = nanstd(m(:));
%     TetdOLAIs = nanstd(o(:));
    TetdCLAIs = nanstd(c(:));
    
%     MeanMLAIx(:,Year - 2000) = TempMLAI;
%     MeanOLAIx(:,Year - 2000) = TempOLAI;
    MeanCeLAIx(:,Year - 2000) = TempCLAI;
    
%     MeanMLAIn(:,Year - 2000) = TempMLAIn;
%     MeanOLAIn(:,Year - 2000) = TempOLAIn;
    MeanCeLAIn(:,Year - 2000) = TempCLAIn;

%     MeanMLAIs(:,Year - 2000) = TempMLAIs;
%     MeanOLAIs(:,Year - 2000) = TempOLAIs;
    MeanCeLAIs(:,Year - 2000) = TempCLAIs;

%     StdMLAIx(:,Year - 2000) = TetdMLAI;
%     StdOLAIx(:,Year - 2000) = TetdOLAI;
    StdCeLAIx(:,Year - 2000) = TetdCLAI;

%     StdMLAIn(:,Year - 2000) = TetdMLAIn;
%     StdOLAIn(:,Year - 2000) = TetdOLAIn;
    StdCeLAIn(:,Year - 2000) = TetdCLAIn;

%     StdMLAIs(:,Year - 2000) = TetdMLAIs;
%     StdOLAIs(:,Year - 2000) = TetdOLAIs;
    StdCeLAIs(:,Year - 2000) = TetdCLAIs;

end

save([Path_TrendLAIx,'TrendCeLAIx.mat'],'-regexp','^Mean*','^Std*');

%% figure
% 
%     Fig=figure;
%     set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
%     set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
%     x=(2001:2017);
%     
%     set(gca,'ylim',[2 4],'ytick',2:0.5:4,'fontsize',28,'Fontname','Times New Roman'); 
%     set(gca,'xlim',[2001 2017],'xtick',2001:3:2017,'fontsize',32,'Fontname','Times New Roman');      
%     p = polyfit(x,MeanMLAIn,1);
%     yfit = polyval(p,x);
%     plot(x,MeanMLAIn,'color',[0.2  0.2  0.976],'LineWidth',1);
%     MLAIx = plot(x,MeanMLAIn,'bo',x,yfit,'b-','LineWidth',3);
%    
%     hold on; 
%     p = polyfit(x,MeanOLAIn,1);
%     yfit = polyval(p,x);
%     plot(x,MeanOLAIn,'r','LineWidth',1);
%     OLAIx = plot(x,MeanOLAIn,'ro',x,yfit,'r-','LineWidth',3);
% 
%     
%     p = polyfit(x,MeanCLAIn,1);
%     yfit = polyval(p,x);
%     plot(x,MeanCLAIn,'g','LineWidth',1);
%     CLAIx = plot(x,MeanCLAIn,'go',x,yfit,'g-','LineWidth',3); 
% 
%     
%     Rm = rvalue(MeanOLAIn(:),MeanMLAIn(:));
%     Rc = rvalue(MeanOLAIn(:),MeanCLAIn(:));
%  
%     