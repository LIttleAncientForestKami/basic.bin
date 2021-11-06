#!/bin/zsh

if [[ $1 == "-h" || $1 = "-p" || $# = 0 ]]; then
    echo "Wywołaj $(basename $0) nazwaPrezentacji by mieć taki katalog i w nim pliki prezki, z odowiednim tytułem."
    exit
fi
NAME=${1}
PROJECT_PATH=/home/tammo/Dokumenty/Prezki

cd $PROJECT_PATH
mkdir $NAME
cd $NAME

git init

source /home/tammo/.oh-my-zsh/plugins/gitignore/gitignore.plugin.zsh
gi vim > .gitignore
echo "Ignoruję pliki generowane z ADOCa, domyślnie PDF i HTML"
echo '*.pdf' >> .gitignore
echo '*.html' >> .gitignore
mkdir img mods
echo "Kopiuję pliki"
cp ~/bin/mantry/szkieletSzkolenia/img/{favicon.ico,LAFK_pl.png,LAFK_pl_wSieci.png,question-mark.jpg} img
cp ~/bin/mantry/szkieletSzkolenia/{x.adoc,x-docinfo.html,przypominajka.sh} .
cp ~/bin/mantry/szkieletSzkolenia/mods/oMnie.adoc mods
echo "Dostosowuję pliki prezki wg nadanej nazwy: ${NAME}"
mv x.adoc ${NAME}.adoc
mv x-docinfo.html ${NAME}-docinfo.html
sed -i s/" x"/" ${NAME}"/g ${NAME}.adoc
sed -i s/wpro.adoc/oMnie.adoc/g ${NAME}.adoc
sed -i /org.adoc/d ${NAME}.adoc
git add .
git commit -m "Preso: $NAME stub done"
git log
