#!/bin/bash
InPath='../input';
OuPath='../input';
#RfPath='misc/'

#rm -rf   $OuPath/
#mkdir -p $OuPath/

Thread=1;
for InName in $(ls $InPath/Globe.DEM.CMG1km.tif); do
  InFile=$(echo $InName | awk -F/ '{print $NF}');
  OuFile=$(echo $InFile | sed 's/1km/005C/g') ;
  OuName=$OuPath/$OuFile;

  echo "gdalwarp $InName $OuName -r mode -tr 0.0500 0.0500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs \""+proj=longlat +ellps=WGS84\"" & "

  gdalwarp $InName $OuName -r mode -tr 0.0500 0.0500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs "+proj=longlat +ellps=WGS84" &

  echo $(( Thread++ )); if (( $Thread % 12 ==0 )); then wait; fi
done

