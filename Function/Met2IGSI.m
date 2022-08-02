function IGSI=Met2IGSI(Pho,Tmn,VPD)

% Pho=11
% Tmn = 3
% VPD = 2.5

% Phomax = 11;        % hour
% Phomin = 10;        % hour
% 
% Tmnmin = -2;     	% C
% Tmnmax =  5;        % C
% 
% VPDmax = 4.1;       % kPa
% VPDmin = 0.9;       % kPa

Phomax = 11.57;        % hour
Phomin = 8.54;        % hour

Tmnmin = -0.76;     	% C
Tmnmax =  6.64;        % C

VPDmax = 1.74;       % kPa
VPDmin = 0.70;       % kPa

IPho = (Pho-Phomin)/(Phomax-Phomin);
IPho = min(max(0,IPho),1);

ITmn = (Tmn-Tmnmin)/(Tmnmax-Tmnmin);
ITmn = min(max(0,ITmn),1);

IVPD = 1 - (VPD-VPDmin)/(VPDmax-VPDmin);
IVPD = min(max(0,IVPD),1);


IGSI = IVPD .* ITmn .* IPho;

