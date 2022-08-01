function MdlYLAI=Budyko2LAI(YRg,YPre,AvgYFpar,YTaRng,YElev,Emax,Cgma,A,B,C,D)

% Cgma = 1.9951; %LAI

AmI = YRg .* Emax .* 0.95 .* 0.45; % MJ/m2/yr
AmP = YPre .* Cgma; 

Alpha = A.* AvgYFpar + B .* YTaRng +C .* YElev +D;

Alpha(Alpha<0) = 0;

% Budyko
MdlYLAI = (AmP .* AmI) ./ (AmP.^Alpha + AmI.^Alpha).^(1./Alpha);
MdlYLAI(MdlYLAI<0.01) = nan;
