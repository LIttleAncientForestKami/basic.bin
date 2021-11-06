#!/bin/zsh

echo jeszcze niegotowa, zacznij od testów
echo https://dev.to/codemouse92/dead-simple-python-virtual-environments-and-pip-5b56
echo https://dev.to/codemouse92/dead-simple-python-project-structure-and-imports-38c6
echo https://www.jetbrains.com/help/pycharm/creating-and-running-your-first-python-project.html#creating-simple-project
echo https://docs.python-guide.org/writing/structure/ 
exit 256

NAME=$1
PROJECT_PATH=/home/tammo/Kod/

function gitignore() {
    source /home/tammo/.oh-my-zsh/plugins/gitignore/gitignore.plugin.zsh
    gi python,vim > .gitignore
}

function setup() {


}

function reqs() {
    echo "# created by LAFK_pl's Python3 mantra
    ###### Requirements without Version Specifiers ######
# req1
# req2
#
###### Requirements with Version Specifiers ######
#   See https://www.python.org/dev/peps/pep-0440/#version-specifiers
#docopt == 0.6.1             # Version Matching. Must be version 0.6.1
#keyring >= 4.1.1            # Minimum version 4.1.1
#coverage != 3.5             # Version Exclusion. Anything except version 3.5
#Mopidy-Dirble ~= 1.1        # Compatible release. Same as >= 1.1, == 1.*
#" > requirements.txt
}    


cd $PROJECT_PATH
mkdir $NAME.py
cd $NAME.py

git init

gitignore()
reqs()

echo -e "= $NAME \na Python 3 project by @LAFK_pl" > README.adoc
mkdir $NAME docs tests

git add .
git commit -m "A Python3 project $NAME initiated by a LAFK_pl's Python mantra with gitignore and readme"
ls -l
git st
git log
