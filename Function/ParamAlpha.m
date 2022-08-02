function [Emax,Cgma,ParaA,ParaB,ParaC,ParaD,ParaS]=ParamAlpha(TypeCode)
Emax  =nan(size(TypeCode));
Cgma  =nan(size(TypeCode));
ParaA=nan(size(TypeCode));
ParaB=nan(size(TypeCode));
ParaC=nan(size(TypeCode));
ParaD=nan(size(TypeCode));
ParaS=nan(size(TypeCode));


% case 'ENF'
Emax(TypeCode==1)  = 0.962;   % gC/MJ
Cgma(TypeCode==1)  =  2.2343;   % gC Kg/H2O 
ParaA(TypeCode==1)= 1.5853;  
ParaB(TypeCode==1)=  0.0062;  
ParaC(TypeCode==1)=  -0.0018;   
ParaD(TypeCode==1)=  -0.3306;    
ParaS(TypeCode==1)=  1.270;   

% case 'EBF'
Emax(TypeCode==2)  = 1.268;   % gC/MJ
Cgma(TypeCode==2)  = 2.3267;   % gC/MJ 
ParaA(TypeCode==2)= 1.3681;  
ParaB(TypeCode==2)=  0.0070;  
ParaC(TypeCode==2)=  -0.0055;   
ParaD(TypeCode==2)=  -0.4209;
ParaS(TypeCode==2)=  1.021;   
 

% case 'DNF'
Emax(TypeCode==3)  = 1.086;   % gC/MJ
Cgma(TypeCode==3)  =  2.1361;   % gC/MJ  
ParaA(TypeCode==3)= 2.4662 ;  
ParaB(TypeCode==3)=  0.0048;  
ParaC(TypeCode==3)=  -0.0034;   
ParaD(TypeCode==3)=  -0.3815;    
ParaS(TypeCode==3)=  1.242;   

% case 'DBF'
Emax(TypeCode==4)  = 1.165;   % gC/MJ        
Cgma(TypeCode==4)  =  2.0613;   % gC/MJ 
% ParaA(TypeCode==4)= 1.7492;  
% ParaB(TypeCode==4)= 0.0042;  
% ParaC(TypeCode==4)=  -0.0030;   
% ParaD(TypeCode==4)=  -0.3399;
ParaA(TypeCode==4)= 0.8092;  
ParaB(TypeCode==4)= 0.0049;  
ParaC(TypeCode==4)=  -0.0064;   
ParaD(TypeCode==4)=  0.2497;   
ParaS(TypeCode==4)=  1.122;   

% case 'MIF'
Emax(TypeCode==5)  = 1.051;   % gC/MJ        
Cgma(TypeCode==5)  =  2.5500;   % gC/MJ 
ParaA(TypeCode==5)= 1.1089;  
ParaB(TypeCode==5)=  0.0086;  
ParaC(TypeCode==5)=  -0.0039;   
ParaD(TypeCode==5)=  -0.1593; 
ParaS(TypeCode==5)=  1.170;   

% case 'CSH'
Emax(TypeCode==6)  = 1.281;   % gC/MJ        
Cgma(TypeCode==6)  = 2.4937;   % gC/MJ
ParaA(TypeCode==6) = 0.1393;   
ParaB(TypeCode==6) =  0.0062;   
ParaC(TypeCode==6) = -0.0078;   
ParaD(TypeCode==6) =  0.0643;  
ParaS(TypeCode==6) =  1.323;  

% case 'OSH'
Emax(TypeCode==7)  =  0.841;   % gC/MJ        
Cgma(TypeCode==7)  = 2.4937;   % gC/MJ  
ParaA(TypeCode==7)= 0.1393;   
ParaB(TypeCode==7)=  0.0062;   
ParaC(TypeCode==7)=  -0.0078;   
ParaD(TypeCode==7)=  0.0643;   
ParaS(TypeCode==7)=  1.323;  

% case 'WSA'
Emax(TypeCode==8)  = 1.239;   % gC/MJ
Cgma(TypeCode==8)  =  2.4662;   % gC/MJ
ParaA(TypeCode==8)= 0.6282;  
ParaB(TypeCode==8)= 0.0052;  
ParaC(TypeCode==8)=  -0.0033;   
ParaD(TypeCode==8)=  0.0449;
% ParaA(TypeCode==8)= 0.2342;  
% ParaB(TypeCode==8)= 0.0032;  
% ParaC(TypeCode==8)=  -0.0052;   
% ParaD(TypeCode==8)=  0.2664;   
ParaS(TypeCode==8)=  1.164;  

% case 'SAV'
Emax(TypeCode==9)  = 1.206;   % gC/MJ
Cgma(TypeCode==9)  =  1.4240;   % gC/MJ 1.4240
ParaA(TypeCode==9)=  0.7195;  
ParaB(TypeCode==9)= 0.0039;  
ParaC(TypeCode==9)=  -0.0053;   
ParaD(TypeCode==9)=  0.1308;
% ParaA(TypeCode==9)=  0.4006;  
% ParaB(TypeCode==9)= 0.0013;  
% ParaC(TypeCode==9)=  -0.0036;   
% ParaD(TypeCode==9)=  0.2275;   
ParaS(TypeCode==9)=  1.124;   

% case 'GRA'
Emax(TypeCode==10)  = 0.860;   % gC/MJ
Cgma(TypeCode==10)  =  1.3155;   % gC/MJ 1.3155
ParaA(TypeCode==10)= 1.2815;  
ParaB(TypeCode==10)=  0.0060;  
ParaC(TypeCode==10)=  -0.0058;   
ParaD(TypeCode==10)=  -0.0399;     
ParaS(TypeCode==10)=  1.187;   

% case 'CRO'
Emax(TypeCode==12)  = 1.044;   % gC/MJ
Cgma(TypeCode==12)  = 2.4937;   % gC/MJ
ParaA(TypeCode==12)= 1.3986;   
ParaB(TypeCode==12)=  0.0031;   
ParaC(TypeCode==12)=  -0.0030;   
ParaD(TypeCode==12)=  -0.0062;  
ParaS(TypeCode==12)=  1.123;   

Emax(TypeCode==14)  = 1.044;   % gC/MJ
Cgma(TypeCode==14)  = 2.4937;   % gC/MJ
ParaA(TypeCode==14)= 1.3986;   
ParaB(TypeCode==14)=  0.0031;   
ParaC(TypeCode==14)=  -0.0030;   
ParaD(TypeCode==14)=  -0.0062;  
ParaS(TypeCode==14)=  1.123;   

