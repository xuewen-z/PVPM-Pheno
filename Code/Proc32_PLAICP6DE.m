
clc; clear;

Path_PLAICP6ME = '../output/31_PLAICP6ME/';
Path_PLAICP6DE = '../output/32_PLAICP6DE/';

% system(['rm -rf '  ,Path_PLAICP6DE]);
% system(['mkdir -p ',Path_PLAICP6DE]);

% for Year = 2001
for Year = 2004:2014
    YearName=num2str(Year);

    File_PLAICP6ME=dir([Path_PLAICP6ME,'*A',YearName,'*']);

%     if numel(File_PLAI15ME1)~=24
%        error('File numbers are not correct!') 
%     end

    % read data
    [PLAICP6ME,R]= geotiffread([File_PLAICP6ME.folder,'/',File_PLAICP6ME.name]);
    Proj = geotiffinfo([File_PLAICP6ME.folder,'/',File_PLAICP6ME.name]);
%     PLAI15ME1 = nan([R.RasterSize 24]);
%     for I_File=1:numel(File_PLAI15ME1)
%         PLAI15ME1(:,:,I_File)=geotiffread([File_PLAI15ME1(I_File).folder,'/',File_PLAI15ME1(I_File).name]);
%     end
%     PNAN15DE1=sum(isnan(PLAI15ME1),3);
    
    % temporary files
%     PLAI15TMP = PLAI15ME1;
%     PLAI15TMP = movmedian(PLAI15TMP,2*3+1,3,'omitnan');
    PLAICP6GF  = double(PLAICP6ME);
%     PLAI15GF(isnan(PLAI15ME1)) = PLAI15TMP(isnan(PLAI15ME1));
    
    % fill gap
%     PLAI15TMP = permute(PLAI15TMP,[3 1 2]);
%     PLAI15TMP = reshape(PLAI15TMP,size(PLAI15ME1,3),[]);
%     PLAI15TMP = fillgaps(PLAI15TMP,3);
%     PLAI15TMP = reshape(PLAI15TMP,size(PLAI15ME1,3),size(PLAI15ME1,1),[]);
%     PLAI15GF  = permute(PLAI15TMP,[2 3 1]);
    
    % remove spike
    PLAICP6TMP = permute(PLAICP6GF,[3 1 2]);
    PLAICP6TMP = reshape(PLAICP6TMP,size(PLAICP6ME,3),[]);
    PLAICP6TMP = hampel(PLAICP6TMP);
    PLAICP6TMP = reshape(PLAICP6TMP,size(PLAICP6ME,3),size(PLAICP6ME,1),[]);    
    PLAICP6HAM = permute(PLAICP6TMP,[2 3 1]);

    % remove spike
    PLAICP6TMP = permute(PLAICP6HAM,[3 1 2]);
    PLAICP6TMP = reshape(PLAICP6TMP,size(PLAICP6ME,3),[]);
    PLAICP6TMP = hampel(PLAICP6TMP);
    PLAICP6TMP = reshape(PLAICP6TMP,size(PLAICP6ME,3),size(PLAICP6ME,1),[]);    
    PLAICP6HAM = permute(PLAICP6TMP,[2 3 1]);
    
    % savitzky-golay filter
    PLAICP6TMP = permute(PLAICP6HAM,[3 1 2]);
    PLAICP6TMP = reshape(PLAICP6TMP,size(PLAICP6ME,3),[]);
    PLAICP6TMP = sgolayfilt(PLAICP6TMP,3,7);
    PLAICP6TMP = reshape(PLAICP6TMP,size(PLAICP6ME,3),size(PLAICP6ME,1),[]);    
    PLAICP6SG  = permute(PLAICP6TMP,[2 3 1]);

    % interpolation
    PLAICP6TMP = permute(PLAICP6SG,[3 1 2]);    
    PLAICP6TMP = reshape(PLAICP6TMP,size(PLAICP6SG,3),[]);    

%     PLAI15INT = interp1(7:15:365,PLAI15TMP,1:365,'linear');
    PLAICP6INT = interp1(15:30:365,PLAICP6TMP,1:365,'linear','extrap');
    PLAICP6INT = reshape(PLAICP6INT,365,size(PLAICP6SG,1),[]);
    PLAICP6DE1 = permute(PLAICP6INT,[2 3 1]);

    % round
    PLAICP6DE1 =round(PLAICP6DE1,2);
% %     PLAI15DE1 =round(PLAI15GF,2);
% 
%     figure;hold on;
%     plot(7:15:365,squeeze(PLAI15ME1(633,1174,:)),'-k')
%     plot(7:15:365,squeeze(PLAI15GF(633,1174,:)),'-b')
%     plot(7:15:365,squeeze(PLAI15HAM(633,1174,:)),'-y')
%     plot(7:15:365,squeeze(PLAI15SG(633,1174,:)),'-g')
%     plot(1:365,squeeze(PLAI15DE1(633,1174,:)),'-r')

    % write data
%     FileName=regexprep(File_PLAI15ME1.name,'abl','nan');
%     geotiffwrite([Path_PLAI15DE1,FileName],PNAN15DE1,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
    FileName=regexprep(File_PLAICP6ME.name,[YearName,'01-12'],[YearName,'001']);
    geotiffwrite([Path_PLAICP6DE,FileName],PLAICP6DE1,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    disp(['Done with ',FileName]);
end
