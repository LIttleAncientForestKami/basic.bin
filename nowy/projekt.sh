#!/bin/bash
NAZWA=${1:-"nowyProjekt"}
BAZA=${2:-"pl/lafk/"}

mkdir -p "$NAZWA""/src/main/java/""$BAZA" "$NAZWA""/src/main/resources" "$NAZWA""/src/test/java/""$BAZA"
cd "$NAZWA" || exit
curl -L -s https://gist.githubusercontent.com/LIttleAncientForestKami/c9b185c123fc97f6022861f645766aa5/raw/45db276f570fcca357fbcf36b6209517c69c6427/pom.xml > pom.xml

cat << EOF > readme.md
= About $NAZWA

What is it:
Purpose: 
Autor: @LAFK_pl

== Launching

1. Prerequisites: JDK 8, Debian-derivatives
2. Setup: nothing aside from prerequisites
3. Launch: \`mvn clean install; cd target; java -jar $NAZWA.jar #or $NAZWA-someFloatingPointNumbers.jar\`

EOF

curl -L -s https://www.gitignore.io/api/java,maven,linux,intellij,vim >> .gitignore
idea pom.xml
