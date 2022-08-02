clc; clear;

Path_LAIIS ='../input/';
Path_SituLAI ='../output/45_SituLAI/';

mkdir(Path_SituLAI);

TableOut=readtable([Path_LAIIS,'LAI_Data_AD.csv']);

% write to .mat
    SiteName = [TableOut.Site];
    SiteYear = [TableOut.Year];
    SiteDOY = [TableOut.DOY];
    SitefPAR = [TableOut.fAPAR_LAIr];
    
    NameID = {'US-Ha1','US-MMS','US-UMB','US-WCr'};
    I_Code = ismember(SiteName,NameID);
    SiteName(~I_Code) =[];
    SiteYear(~I_Code) =[];
    SitefPAR(~I_Code) =[];
    SiteDOY(~I_Code) =[];
    SiteDLAI = 2.* log(1./(1-SitefPAR));

    save([Path_SituLAI,'SituLAI.mat'],'-regexp','^Site*');

