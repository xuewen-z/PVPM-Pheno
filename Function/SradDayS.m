function [DRa,DPho]=SradDayS(Lat,Lon,Year)

% Calculate Extraterrestrial radiation (Ra) and Sun Zenith Angle (SZA)
% Input: Lat, Lon (in degree)

% Output: Daily Extraterrestrial radiation (DRa)  (in W/m2)
% Output: Daily sun hours (Pho)  (in hours) 

DayNum = yeardays(Year);

Lt = repmat(reshape(Lat,[],1),1,DayNum);
J  = repmat(reshape(1 : DayNum , 1,[]),numel(Lat),1);

phi  = deg2rad(Lt);
Gsc  = 0.082;
dr   = 1+0.033*cos(2*pi/365*J);                     % Eq 23
delta= 0.409*sin(2*pi/365*J-1.39);                  % Eq 24

% sunset solar time angle (omegas; Allen Eq 25)
X=-tan(phi).*tan(delta);
X(X>1)=1;
X(X<-1)=-1;
omegas= acos(X);

DRa   =24*60/pi*Gsc*dr.*( omegas.*sin(phi).*sin(delta)+cos(phi).*cos(delta).*sin(omegas) );
DPho  =24/pi*omegas;

DRa   = reshape(DRa ,size(Lat,1),size(Lat,2),[]);
DPho  = reshape(DPho,size(Lat,1),size(Lat,2),[]);

DRa   = squeeze(DRa);
DPho  = squeeze(DPho);

DRa   = DRa*10^6/3600/24;
