#!/bin/bash
InPath='../output/37_CESM2';  #30_GFDLCM4'
OuPath='../output/31_PLAICP6ME';  
#RfPath='misc/'

#rm -rf   $OuPath/
#mkdir -p $OuPath/

#Thread=1;
for InName in $(ls $InPath/*tif); do
  InFile=$(echo $InName | awk -F/ '{print $NF}');
  OuFile=$(echo $InFile | sed 's/100km/005c/g');
  OuName=$OuPath/$OuFile;

  echo "gdalwarp $InName $OuName -r bilinear -tr 0.05 0.05 -te 0 -60 360 90 -t_srs '+proj=longlat +ellps=WGS84' -dstnodata 0 & "

  gdal_translate $InName $OuFile;
#  gdal_translate $OuFile "Temp000"$OuFile -projwin 0 90 180 -90 -a_nodata 0;
#  gdal_translate $OuFile "Temp180"$OuFile -projwin 180 90 360 -90 -a_ullr -180 90 0 -90 -a_nodata 0;
#  gdal_merge.py -o "Temp"$OuFile "Temp000"$OuFile "Temp180"$OuFile;
  gdalwarp $OuFile $OuName -r bilinear -tr 0.05 0.05 -te -180 -60 180 90 -t_srs '+proj=longlat +ellps=WGS84' -dstnodata 0;
#  rm -rf $OuFile "Temp000"$OuFile "Temp180"$OuFile "Temp"$OuFile;

  echo $(( Thread++ )); if (( $Thread % 12 ==0 )); then wait; fi
   
done











