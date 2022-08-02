function [mRatio,kLeaf]=ParamSGPD(TypeCode)

mRatio=nan(size(TypeCode));
kLeaf =nan(size(TypeCode));

% case 'ENF'
mRatio(TypeCode==1)=  0.645;
kLeaf(TypeCode==1) = 0.0360;

% case 'EBF'
% mRatio(TypeCode==2)=  0.545;        % calibrated based on site type
% kLeaf(TypeCode==2) = 0.0101;
mRatio(TypeCode==2)=  0.973;        % calibrated based on MODIS type
kLeaf(TypeCode==2) =  0.006;

% case 'DNF'
mRatio(TypeCode==3)=  0.399;        % calibrated based on MODIS type
kLeaf(TypeCode==3) = 0.0466;

% case 'DBF'
% mRatio(TypeCode==4)=  0.699;
% kLeaf(TypeCode==4)=  0.0694;
mRatio(TypeCode==4)=  0.622;
kLeaf(TypeCode==4)=  0.0692;

% case 'MIF'
mRatio(TypeCode==5)=  0.559;
kLeaf(TypeCode==5) = 0.0559;

% case 'CSH'
mRatio(TypeCode==6)=  0.998;
kLeaf(TypeCode==6) = 0.0352;

% case 'OSH'
mRatio(TypeCode==7)=  0.431;
kLeaf(TypeCode==7) = 0.0448;

% case 'WSA'
mRatio(TypeCode==8)=  0.371;
kLeaf(TypeCode==8) = 0.0695;

% case 'SAV'
mRatio(TypeCode==9)=  0.414;
kLeaf(TypeCode==9) = 0.0264;

% case 'GRA'
mRatio(TypeCode==10)= 0.609;
kLeaf(TypeCode==10) =0.0403;

% case 'CRO'
mRatio(TypeCode==12)= 0.271;
kLeaf(TypeCode==12) =0.1708;

% case 'CRO & natural vegetation'
mRatio(TypeCode==14)= 0.621;
kLeaf(TypeCode==14) =0.0539;

