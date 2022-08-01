#!/bin/bash

InPath='../input/GLDAS_NOAH025_DLAI';
OuPath='../input/GLDAS_NOAH005_DHalf_V02C';


rm -rf   $OuPath/
mkdir -p $OuPath/

for Year in {2001..2017..1}; do

  mkdir -p  $OuPath/$Year

  Thread=0;
  Number=10;

  for InName in $(ls $InPath/$Year/*"GLDAS"*); do
    InFile=$(echo $InName | awk -F/ '{print $NF}');
    OuFile=$(echo $InFile | sed 's/NOAH025/NOAH005/g') ;
    OuName=$OuPath/$Year/$OuFile;

    echo "gdalwarp $InName $OuName -r bilinear -tr 0.0500 0.0500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs \""+proj=longlat +ellps=WGS84\"" & "

    gdalwarp $InName $OuName -r bilinear -tr 0.0500 0.0500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs "+proj=longlat +ellps=WGS84" &

    Thread=`expr $Thread + $Number`;echo $Thread; if (( $Thread % 12 ==0 )); then wait; fi

  done

done
