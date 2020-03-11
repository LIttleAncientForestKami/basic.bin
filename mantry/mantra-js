#!/bin/zsh

NAME=$1
PROJECT_PATH=/home/tammo/RDZ/

cd $PROJECT_PATH
mkdir $NAME
cd $NAME

git init

source /home/tammo/.oh-my-zsh/plugins/gitignore/gitignore.plugin.zsh
gi vim > .gitignore # no JavaScript in gitignore.io
echo -e "# $NAME \nJS project by @LAFK_pl" > README.md
mkdir img css js
git add .
git commit -m "JS project $NAME initiated with gitignore and readme"
ls -l
git st
git log
