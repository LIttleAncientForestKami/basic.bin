#!/bin/bash

usuwaNawiasy() {
    for f in $(ls *); do
        # usuwa nawiasy
        nazwa=$(echo $f | tr -d \(\)\[\]\{\})
        mv $f $nazwa
    done
}

cvkiDoKatalogu() {
    echo przerzucam CV do tymczasowego katalogu
    cd ~/Pobrane || exit -2
    mkdir -p temp.cv
    echo PDFów jest: $(ls *.pdf -l | wc -l)
    echo Zaczynających się od CV
    mv CV*.pdf temp.cv
    ls temp.cv/*.pdf -l | wc -l
    cd temp.cv || exit -2
}

cvkiDoKatalogu
usuwaNawiasy

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
