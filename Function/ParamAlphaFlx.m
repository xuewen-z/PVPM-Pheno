function [Emax,Cgma,ParaA,ParaB,ParaC,ParaD]=ParamAlphaFlx1(TypeCode)
Emax  =nan(size(TypeCode));
Cgma  =nan(size(TypeCode));
ParaA=nan(size(TypeCode));
ParaB=nan(size(TypeCode));
ParaC=nan(size(TypeCode));
ParaD=nan(size(TypeCode));


% case 'ENF'
Emax(TypeCode==1)  = 0.962;   % gC/MJ
Cgma(TypeCode==1)  =  1.5248;   % gC Kg/H2O   
ParaA(TypeCode==1)= 2.0193;  
ParaB(TypeCode==1)=  0.0088;  
ParaC(TypeCode==1)=  -0.0020;   
ParaD(TypeCode==1)=  -0.4230;   

% case 'EBF'
Emax(TypeCode==2)  = 1.268;   % gC/MJ
Cgma(TypeCode==2)  = 1.7514;   % gC/MJ 
ParaA(TypeCode==2)= 0.6149;  
ParaB(TypeCode==2)=  0.0069;  
ParaC(TypeCode==2)=  -0.0017;   
ParaD(TypeCode==2)=  0.3720; 
% ParaA(TypeCode==2)= 1.6566;  
% ParaB(TypeCode==2)=  0.0098;  
% ParaC(TypeCode==2)=  -0.0049;   
% ParaD(TypeCode==2)=  -0.4917;   

% case 'DNF'
% Emax(TypeCode==3)  = 1.086;   % gC/MJ
% Cgma(TypeCode==3)  =  2.1361;   % gC/MJ  
% ParaA(TypeCode==3)= 2.4662 ;  
% ParaB(TypeCode==3)=  0.0048;  
% ParaC(TypeCode==3)=  -0.0034;   
% ParaD(TypeCode==3)=  -0.3815;   

% case 'DBF'
Emax(TypeCode==4)  = 1.165;   % gC/MJ        
Cgma(TypeCode==4)  =  1.9723;   % gC/MJ 
ParaA(TypeCode==4)= 1.5953;  
ParaB(TypeCode==4)= 0.0062;  
ParaC(TypeCode==4)=  -0.0018;   
ParaD(TypeCode==4)=  -0.3306;   

% case 'MIF'
Emax(TypeCode==5)  = 1.051;   % gC/MJ        
Cgma(TypeCode==5)  =  1.4150;   % gC/MJ 
ParaA(TypeCode==5)= 1.4142;  
ParaB(TypeCode==5)=  0.0093;  
ParaC(TypeCode==5)=  -0.0086;   
ParaD(TypeCode==5)=  -0.1491;   

% case 'CSH'
Emax(TypeCode==6)  = 1.281;   % gC/MJ        
Cgma(TypeCode==6)  = 1.5566;   % gC/MJ
ParaA(TypeCode==6)= 2.7268;   
ParaB(TypeCode==6)=  0.0048;   
ParaC(TypeCode==6)=  -0.0046;   
ParaD(TypeCode==6)=  -0.4543;  

% case 'OSH'
Emax(TypeCode==7)  =  0.841;   % gC/MJ        
Cgma(TypeCode==7)  = 1.0648;   % gC/MJ 
ParaA(TypeCode==7)= 1.8260;   
ParaB(TypeCode==7)=  0.0077;   
ParaC(TypeCode==7)=  -0.0099;   
ParaD(TypeCode==7)=  -0.1386;   

% case 'WSA'
Emax(TypeCode==8)  = 1.239;   % gC/MJ
Cgma(TypeCode==8)  =  0.6889;   % gC/MJ
ParaA(TypeCode==8)= 0.8457;  
ParaB(TypeCode==8)= 0.0060;  
ParaC(TypeCode==8)=  -0.0059;   
ParaD(TypeCode==8)=  0.1091;   

% case 'SAV'
Emax(TypeCode==9)  = 1.206;   % gC/MJ
Cgma(TypeCode==9)  =  0.7622;   % gC/MJ 1.4240
ParaA(TypeCode==9)=  0.6396;  
ParaB(TypeCode==9)= 0.0040;  
ParaC(TypeCode==9)=  -0.0023;   
ParaD(TypeCode==9)=  0.2702;   

% case 'GRA'
Emax(TypeCode==10)  = 0.860;   % gC/MJ
Cgma(TypeCode==10)  =  0.9621;   % gC/MJ 1.3155
ParaA(TypeCode==10)= 2.6595;  
ParaB(TypeCode==10)=  0.0031;  
ParaC(TypeCode==10)=  -0.0024;   
ParaD(TypeCode==10)=  -0.2020; 
% ParaA(TypeCode==10)= 2.9421;  
% ParaB(TypeCode==10)=  0.0085;  
% ParaC(TypeCode==10)=  -0.0079;   
% ParaD(TypeCode==10)=  -0.4813;   

% case 'CRO'
Emax(TypeCode==12)  = 1.044;   % gC/MJ
Cgma(TypeCode==12)  = 2.4937;   % gC/MJ
ParaA(TypeCode==12)= 1.3986;   
ParaB(TypeCode==12)=  0.0031;   
ParaC(TypeCode==12)=  -0.0030;   
ParaD(TypeCode==12)=  -0.0062;  

Emax(TypeCode==14)  = 1.044;   % gC/MJ
Cgma(TypeCode==14)  = 2.4937;   % gC/MJ
ParaA(TypeCode==14)= 1.3986;   
ParaB(TypeCode==14)=  0.0031;   
ParaC(TypeCode==14)=  -0.0030;   
ParaD(TypeCode==14)=  -0.0062;  

