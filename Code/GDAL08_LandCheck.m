
clc; clear;

Path_LandCover = '../input/';
Path_LandCheck = '../input/LandCheck/';

system(['rm -rf   ',Path_LandCheck]);
system(['mkdir -p ',Path_LandCheck]);

% geoinformation
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG500MG_USGS.tif']); 
Proj  = geotiffinfo([Path_LandCover,'LCT_Mul_CMG500MG_USGS.tif']);

% ENF =1
Landtemp = double(Landcover);
Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; Landtemp(Landtemp==4)=0; 
Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; Landtemp(Landtemp==7)=0; 
Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
LandENF = Landtemp;

% write data
FileName=['LandENF_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandENF,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


% EBF =2
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==3)=0; Landtemp(Landtemp==4)=0; 
Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; Landtemp(Landtemp==7)=0; 
Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==2)=1;
LandEBF = Landtemp;

% write data
FileName=['LandEBF_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandEBF,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


% DNF =3
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==4)=0; 
Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; Landtemp(Landtemp==7)=0; 
Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==3)=1;
LandDNF = Landtemp;

% write data
FileName=['LandDNF_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandDNF,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% DBF =4
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; 
Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; Landtemp(Landtemp==7)=0; 
Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==4)=1;
LandDBF = Landtemp;

% write data
FileName=['LandDBF_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandDBF,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% MIF =5
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; 
Landtemp(Landtemp==4)=0; Landtemp(Landtemp==6)=0; Landtemp(Landtemp==7)=0; 
Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==5)=1;
LandMIF = Landtemp;

% write data
FileName=['LandMIF_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandMIF,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% CSH =6
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; 
Landtemp(Landtemp==4)=0; Landtemp(Landtemp==5)=0; Landtemp(Landtemp==7)=0; 
Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==6)=1;
LandCSH = Landtemp;

% write data
FileName=['LandCSH_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandCSH,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% OSH =7
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; 
Landtemp(Landtemp==4)=0; Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; 
Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==7)=1;
LandOSH = Landtemp;

% write data
FileName=['LandOSH_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandOSH,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% WSA =8
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; 
Landtemp(Landtemp==4)=0; Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; 
Landtemp(Landtemp==7)=0; Landtemp(Landtemp==9)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==8)=1;
LandWSA = Landtemp;

% write data
FileName=['LandWSA_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandWSA,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% SAV =9
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; 
Landtemp(Landtemp==4)=0; Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; 
Landtemp(Landtemp==7)=0; Landtemp(Landtemp==8)=0; Landtemp(Landtemp==10)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==9)=1;
LandSAV = Landtemp;

% write data
FileName=['LandSAV_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandSAV,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

% GRA =10
Landtemp = double(Landcover);
Landtemp(Landtemp==1)=0; Landtemp(Landtemp==2)=0; Landtemp(Landtemp==3)=0; 
Landtemp(Landtemp==4)=0; Landtemp(Landtemp==5)=0; Landtemp(Landtemp==6)=0; 
Landtemp(Landtemp==7)=0; Landtemp(Landtemp==8)=0; Landtemp(Landtemp==9)=0; 
Landtemp(Landtemp==11)=0; Landtemp(Landtemp==12)=0; Landtemp(Landtemp==13)=0; 
Landtemp(Landtemp==14)=0; Landtemp(Landtemp==15)=0; Landtemp(Landtemp==16)=0; 
Landtemp(Landtemp==10)=1;
LandGRA = Landtemp;

% write data
FileName=['LandGRA_Mul_CMG500M_USGS.tif'];
geotiffwrite([Path_LandCheck,FileName],LandGRA,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


 



