#!/bin/bash

TAG="zrzuty-ekranu"
SORT_DIR="/home/tammo/Obrazy/DPR_dziś/"

logger -t $TAG "Start sortowania zrzutów ekranu dla $SORT_DIR"

cd $SORT_DIR || exit 2
# tworzymy katalogi rok/miesiąc
ls *.png | awk -F '-' '{print $1" " $2}' | uniq | while read year month; do 
    YM="$year/$month"
    echo $YM
    mkdir -p $YM
    ile=$(ls $year-$month-* | wc -l)
    logger -t $TAG "Plików $YM znaleziono $ile"
    mv $year-$month-*.png $YM/
done
