#!/bin/bash

ZLY_WZORZEC="[ +-]"
PODMIANA="_"
USUN_CV="CV_"

export IFS=$'\n'
for f in $(ls -1 *.pdf); do
   [[ "$f" =~ "$ZLY_WZORZEC" ]]
      fPodmienione=${f//$ZLY_WZORZEC/$PODMIANA}
      fBezCV=${fPodmienione#$USUN_CV}
      mv "$f" $fBezCV
done
