function [Emax,Tmnmin,Tmnmax,VPDmin,VPDmax]=ParamMOD17C(TypeCode)

Emax  =nan(size(TypeCode));
Tmnmin=nan(size(TypeCode));
Tmnmax=nan(size(TypeCode));
VPDmin=nan(size(TypeCode));
VPDmax=nan(size(TypeCode));

% MOD17 Version 6       (MOD17 user guide 2015/07/10 page 12/28)

% case 'ENF'
Emax(TypeCode==1)  = 1.291;   % gC/MJ
Tmnmin(TypeCode==1)=-10.00;   % C
Tmnmax(TypeCode==1)=  2.77;   % C
VPDmin(TypeCode==1)=  0.50;   % kPa
VPDmax(TypeCode==1)=  2.98;   % kPa

% case 'EBF'
Emax(TypeCode==2)  = 1.232;   % gC/MJ
Tmnmin(TypeCode==2)=-10.00;   % C
Tmnmax(TypeCode==2)=  7.25;   % C
VPDmin(TypeCode==2)=  0.50;   % kPa
VPDmax(TypeCode==2)=  2.80;   % kPa

% case 'DNF'
Emax(TypeCode==3)  = 1.692;   % gC/MJ
Tmnmin(TypeCode==3)=-10.00;   % C
Tmnmax(TypeCode==3)=  6.32;   % C
VPDmin(TypeCode==3)=  0.50;   % kPa
VPDmax(TypeCode==3)=  2.75;   % kPa

% case 'DBF'
Emax(TypeCode==4)  = 1.391;   % gC/MJ        
Tmnmin(TypeCode==4)= -6.93;   % C
Tmnmax(TypeCode==4)= 13.68;   % C
VPDmin(TypeCode==4)=  0.50;   % kPa
VPDmax(TypeCode==4)=  3.06;   % kPa

% case 'MIF'
Emax(TypeCode==5)  = 1.163;   % gC/MJ        
Tmnmin(TypeCode==5)= -8.39;   % C
Tmnmax(TypeCode==5)=  5.17;   % C
VPDmin(TypeCode==5)=  0.50;   % kPa
VPDmax(TypeCode==5)=  6.00;   % kPa

% case 'CSH'
Emax(TypeCode==6)  = 0.855;   % gC/MJ        
Tmnmin(TypeCode==6)= -9.03;   % C
Tmnmax(TypeCode==6)=  0.00;   % C
VPDmin(TypeCode==6)=  0.50;   % kPa
VPDmax(TypeCode==6)=  2.06;   % kPa

% case 'OSH'
Emax(TypeCode==7)  = 1.088;   % gC/MJ        
Tmnmin(TypeCode==7)=-10.00;   % C
Tmnmax(TypeCode==7)=  0.91;   % C
VPDmin(TypeCode==7)=  0.50;   % kPa
VPDmax(TypeCode==7)=  2.80;   % kPa

% case 'WSA'
Emax(TypeCode==8)  = 1.644;   % gC/MJ
Tmnmin(TypeCode==8)=-10.00;   % C
Tmnmax(TypeCode==8)= 28.66;   % C
VPDmin(TypeCode==8)=  0.50;   % kPa
VPDmax(TypeCode==8)=  3.28;   % kPa

% case 'SAV'
Emax(TypeCode==9)  = 1.662;   % gC/MJ
Tmnmin(TypeCode==9)=  3.90;   % C
Tmnmax(TypeCode==9)= 25.40;   % C
VPDmin(TypeCode==9)=  0.68;   % kPa
VPDmax(TypeCode==9)=  3.93;   % kPa

% case 'GRA'
Emax(TypeCode==10)  = 1.363;   % gC/MJ
Tmnmin(TypeCode==10)= -9.67;   % C
Tmnmax(TypeCode==10)=  0.12;   % C
VPDmin(TypeCode==10)=  0.50;   % kPa
VPDmax(TypeCode==10)=  2.52;   % kPa

% case 'CRO'
Emax(TypeCode==12)  = 2.734;   % gC/MJ
Tmnmin(TypeCode==12)=-10.00;   % C
Tmnmax(TypeCode==12)= 22.76;   % C
VPDmin(TypeCode==12)=  0.50;   % kPa
VPDmax(TypeCode==12)=  3.49;   % kPa

% case 'CRO & natural vegetation'
Emax(TypeCode==14)  = 1.502;   % gC/MJ
Tmnmin(TypeCode==14)= -9.96;   % C
Tmnmax(TypeCode==14)= 10.65;   % C
VPDmin(TypeCode==14)=  0.50;   % kPa
VPDmax(TypeCode==14)=  2.21;   % kPa
