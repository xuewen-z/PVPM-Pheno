function SLAI=SGPD2SLAI(DRg,DTmn,DVPD,Emax,Tmnmin,Tmnmax,VPDmin,VPDmax,mRatio)

% the simplied growing production day model to derive steady state leaf area index 

% Rg        % incident shortwave radtion (W/m2)
% Tmn       % minimum temperature (degree in C)
% VPD       % kPa

% % test
% Rg  = 350;
% Tmn =  20;
% VPD = 1.0;

% global Emax Tmnmin Tmnmax VPDmin VPDmax

% % parameterization
% ParamMOD17(Type);

Ratio = 0.5;   % incident PAR from incident shortwave radtion

% conversion (from W/m2 to MJ/m2/d)
PAR    = Ratio * DRg * 3600 * 24 / 10^6;    

% scalar
FunTmn = (DTmn-Tmnmin)./(Tmnmax-Tmnmin);
FunTmn(FunTmn<0)=0;
FunTmn(FunTmn>1)=1;

FunVPD = (VPDmax-DVPD)./(VPDmax-VPDmin);
FunVPD(FunVPD<0)=0;
FunVPD(FunVPD>1)=1;

% modeling leaf area index (m2/m2)
KB   = 0.5;
Mu   = mRatio.* Emax .* PAR .* FunTmn .* FunVPD ;

SLAI = Mu + 1./ KB .* lambertw( -Mu .* KB .* exp(-Mu .* KB) );

end
