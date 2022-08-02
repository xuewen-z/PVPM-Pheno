clc; clear;

Path_SituLAI ='../output/45_SituLAI/';
Path_SituDLAI ='../output/46_SituDLAI/';
 
% mkdir(Path_SituDLAI);

load([Path_SituLAI,'SituLAI.mat']);

%%
    SiteID = {'US-Ha1'};
    I_Code = ismember(SiteName,SiteID);
    TempDLAI = SiteDLAI(I_Code);
    TempYear = SiteYear(I_Code);
    TempfPAR = SitefPAR(I_Code);

for Year = 1992:2007
    YearName = num2str(Year);
      
    Year_Inx = ismember(TempYear,Year);

%     DLAI = TempDLAI(Year_Inx);
    DfPAR = TempfPAR(Year_Inx);
    BiomfPAR(:,Year-1991) = DfPAR(1:365,:);
    
end
    HfPAR = nanmean(BiomfPAR,2);
    HDLAI = -(1/0.8).* log(1-HfPAR);

%%
 
 BiomfPAR =[];
 SiteID = {'US-MMS'};
    I_Code = ismember(SiteName,SiteID);
    TempDLAI = SiteDLAI(I_Code);
    TempYear = SiteYear(I_Code);
    TempfPAR = SitefPAR(I_Code);

for Year = 1999:2006
    YearName = num2str(Year);
      
    Year_Inx = ismember(TempYear,Year);

%     DLAI = TempDLAI(Year_Inx);
    DfPAR = TempfPAR(Year_Inx);
    BiomfPAR(:,Year-1998) = DfPAR(1:365,:);
    
end
    MfPAR = nanmean(BiomfPAR,2);
    MDLAI = -(1/0.8) .* log(1-MfPAR);
    
%%
 
 BiomfPAR =[];
 SiteID = {'US-UMB'};
    I_Code = ismember(SiteName,SiteID);
    TempDLAI = SiteDLAI(I_Code);
    TempYear = SiteYear(I_Code);
    TempfPAR = SitefPAR(I_Code);

for Year = 2003:2007
    YearName = num2str(Year);
      
    Year_Inx = ismember(TempYear,Year);

%     DLAI = TempDLAI(Year_Inx);
    DfPAR = TempfPAR(Year_Inx);
    BiomfPAR(:,Year-2002) = DfPAR(1:365,:);
    
end
    UfPAR = nanmean(BiomfPAR,2);
    UDLAI = -(1/0.7).* log(1-UfPAR);
   
%%
 
 BiomfPAR =[];
 SiteID = {'US-WCr'};
    I_Code = ismember(SiteName,SiteID);
    TempDLAI = SiteDLAI(I_Code);
    TempYear = SiteYear(I_Code);
    TempfPAR = SitefPAR(I_Code);

for Year = 1998:2004
    YearName = num2str(Year);
      
    Year_Inx = ismember(TempYear,Year);

%     DLAI = TempDLAI(Year_Inx);
    DfPAR = TempfPAR(Year_Inx);
    BiomfPAR(:,Year-1997) = DfPAR(1:365,:);
    
end
    WfPAR = nanmean(BiomfPAR,2);
    WDLAI = -(1/0.5).* log(1-WfPAR);

    SituDfPAR = [HfPAR,MfPAR,UfPAR,WfPAR];
    SituName = unique(SiteName)';
    SituDLAI = 5.* SituDfPAR;

    save([Path_SituDLAI,'BiomLAI.mat'],'-regexp','^Situ*');
