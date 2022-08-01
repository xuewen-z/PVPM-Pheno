#!/bin/bash
InPath='../input/LandCheck';
OuPath='../input/LandCheck';
#RfPath='misc/'

#rm -rf   $OuPath/
#mkdir -p $OuPath/

 Thread=0;
 Number=10;

for InName in $(ls $InPath/*"Land"*); do
  InFile=$(echo $InName | awk -F/ '{print $NF}');
  OuFile=$(echo $InFile | sed 's/500M/005C/g') ;
  OuName=$OuPath/$OuFile;

  echo "gdalwarp $InName $OuName -r average -tr 0.0500 0.0500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs \""+proj=longlat +ellps=WGS84\"" & "

  gdalwarp $InName $OuName -r average -tr 0.0500 0.0500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs "+proj=longlat +ellps=WGS84" &

  Thread=`expr $Thread + $Number`;echo $Thread; if (( $Thread % 12 ==0 )); then wait; fi

  #echo $(( Thread++ )); if (( $Thread % 12 ==0 )); then wait; fi
done

