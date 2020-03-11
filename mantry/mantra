#!/bin/bash
set +x
NAZWA=${1:-"nowyProjekt"}
JDK=${2:-"11"}
BAZA=${3:-"pl/lafk/"}

echo "Zwykle Kod, tym razem $(pwd)"

mkdir -p "$NAZWA"/src/{main,test}/{java,resources}/"$BAZA"
cd "$NAZWA" || exit
if [[ $JDK = "1.8" ]]; then
    curl -L -s https://gist.githubusercontent.com/LIttleAncientForestKami/c9b185c123fc97f6022861f645766aa5/raw/45db276f570fcca357fbcf36b6209517c69c6427/pom.xml > pom.xml
else curl -L -s https://gist.githubusercontent.com/LIttleAncientForestKami/c9b185c123fc97f6022861f645766aa5/raw/00658d664edeef427c295c15eb353728cbbe8f05/pom.xml > pom.xml
fi

sed -i s/#NAME/"$NAZWA"/g pom.xml
sed -i s/#APP/"$NAZWA"/g pom.xml

cat << EOF > readme.adoc
= About $NAZWA

What is it:
Purpose: 
Author: @LAFK_pl

== Launching

1. Prerequisites: JDK $JDK, Debian-derivatives, Maven 3
2. Setup: nothing aside from prerequisites
3. Launch: \`mvn clean install; cd target; java -jar $NAZWA.jar #or $NAZWA-versionNumbers.jar\`

EOF

curl -L -s https://www.gitignore.io/api/java,maven,linux,intellij,vim >> .gitignore
echo ".idea/" >> .gitignore
echo "*.iml" >> .gitignore
git init
git add .
git-quote "Mantra projektu dla JDK $JDK + Git, Maven, readme i .gitignore Good POM wg LAFK_pl: https://lafkblogs.wordpress.com/2019/09/29/good-pom/"
idea pom.xml
