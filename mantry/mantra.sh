#!/bin/bash
set +x
function pomoc() {
    echo "Mantra: stawia projekt. JDK, Maven, Git, itp. Autor: Tomasz LAFK_pl Borek"
    echo "Przyjmuje długie i krótkie opcje, także mieszane.
Składnia:

mantra - domyślne ustawienia (JDK17, Maven 3.8, katalog nowyProjekt w bieżącym katalogu, .git, .gitignore, pierwsza migawka z readme i strukturą projektową).

mantra -n nazwaProjektuIJegoKatalogu (reszta ustawień - domyślna)

mantra --nazwa=MyProject --bazacom/firma/tjb --repo 0 --kod postawi projekt w Kodzie, bez repo, podstawowe pakiety to com.firma.tjb, nazwa myProject, reszta domyślnie.

Długie opcje można pisać na którykolwiek z 3 sposobów tu prezentowanych: --nazwaAba --nazwa Aba --nazwa=Aba
Krótkie opcje można mieszać: -xk -kx, kolejność nie ma znaczenia, wyjąwszy:

1. p lub t - pomoc lub testy kończą działanie programu.
2. opcje z parametrami, następny element powinien być parametrem!
3. x - informacje z tej opcji spływają od momentu jej sparsowania - im szybciej, tym więcej.

Opcje: 
        -x | --set-x-bash -- drukuje komendy przed ich wykonaniem, diagnostyczna
        -r | --repo     -- ustawia repozytorium na: 0 (bez, brak), GitHub, GitLab (domyślnie), BitBucket
        -n | --nazwa    -- precyzuje nazwę projektu i katalogu projektowego
        -b | --baza     -- określa pakiet bazowy, domyślnie pl/lafk
        -j | --jdk     -- JDK 8, 11 lub 17 (domyślne)
        -k | --kod      -- użycie tej opcji umieści projekt w Kodzie, razem z większymi projektami, pominięcie utworzy tam gdzie wywołano skrypt
        -p | --pomoc    -- wyświetli tę wiadomość i zakończy działanie programu.
        -t | --test     -- testuje przekaz opcji, diagnostyczna (kończy działanie programu).

RDZ:
# lab, hub, bb, z odpowiednim 'origin' i zdalnym repo
# strona mana! :D :D :D
# kompletowanie składni :D <3 :O
# Docker
# Colours in mantra printouts
"
}

function test_opcji() {
    # powtórka dla testu
    GDZIE="${GDZIE}/${NAZWA}"
    # test właściwy
    echo "$0" "$OPCJE"
    echo Nazwa: "$NAZWA" JDK: "$JDK" BAZA: "$BAZA" GDZIE: "$GDZIE" REPO: "$REPO" GIST: "$GIST"
    exit 0
}

OPCJE=$(getopt -o xn:j:kb:r:pt --long set-x-bash,nazwa:,jdk:,kod,baza:,repo:,pomoc,test -n 'mantra' -- "$@")

eval set -- "$OPCJE"
# opcje domyślne są ustawione tutaj
NAZWA="nowyProjekt"
JDK="17"; GIST="9dd9247ad33a84adeef7bfe16f7ea6b1e475c878"
BAZA="pl/lafk/"
REPO=GitLab
GDZIE=$(pwd)

# POMy dla danych JDK
function gist() {
    case "$1" in
        8) JDK="1.8" GIST="45db276f570fcca357fbcf36b6209517c69c6427"; return;;
        11) JDK="11"; GIST="8b152e8379acb403c65afa6bd7127c022cff7205"; return;;
        *) return;;
    esac
}

function kod() {
    GDZIE="$HOME/Kod"
    echo Mantra: przestawiam katalog na "$GDZIE"
}

while true; do
    case "$1" in
        -x | --set-x-bash ) set -x; shift;;
        -r | --repo ) REPO="$2"; shift 2;;
        -n | --nazwa ) NAZWA="$2"; shift 2;;
        -b | --baza ) BAZA="$2"; shift 2;;
        -j | --jdk ) gist "$2"; shift 2;;
        -k | --kod ) kod; shift;;
        -p | --pomoc ) pomoc; exit 0;;
        -t | --test ) test_opcji; exit 0;;
        -- ) shift; break;;
        * ) echo "mantra: Nani?! Mamy nieobsłużoną kombinację?! ${1} ${2}"; break;;
    esac
done
KAT="${GDZIE}/${NAZWA}"
echo mantra: ustawiam katalog apki na "$KAT"

function pom() {
    curl -L -s https://gist.githubusercontent.com/LIttleAncientForestKami/c9b185c123fc97f6022861f645766aa5/raw/${GIST}/pom.xml > pom.xml
}

function maven() {
    mkdir -p "$KAT"/src/{main,test}/{java,resources}/"$BAZA"
    cd "$KAT" || exit
    pom
    sed -i s/#NAME/"$NAZWA"/g pom.xml
    sed -i s/#APP/"$NAZWA"/g pom.xml
}

function repo() {

    case "$REPO" in
        0 | bez | brak ) return;;
        gl | gitlab | GitLab | GL ) echo GitLab;;
        * ) echo "mantra: Nani?! Takiego repo nie znam! ${REPO}"; return;;
    esac
    # patrz na: https://github.com/toptal/gitignore.io/issues/360 i 186#issuecomment-249601023, przekomplikowali
    # dużo tekstu w tym gi a różnica dla intellij+all, intellij+iml, intellij niewielka, zrobienie .idea/ i *.iml lepsze. Jak nie Intellij, to JetBrains (+all/iml itp.)
    { curl -L -s https://www.gitignore.io/api/java,maven,linux,intellij,vim; echo ".idea/"; echo "*.iml"; } >> .gitignore 
    git init
    git add .
    # RDZ: wiadomość wieloliniowa może? czyli z pliku?
    git-quote "Mantra projektu wg LAFK_pl
JDK ${JDK}, ${REPO}, Maven 3.8, readme i .gitignore 
Good POM wg LAFK_pl: https://lafkblogs.wordpress.com/2019/09/29/good-pom/"

}

function repo_remote() {
    echo Zdalne repo działa tylko dla GitLaba.
    case "$REPO" in
        0 | bez | brak ) return;;
        gl | gitlab | GitLab | GL ) echo GitLab; git push --set-upstream git@gitlab.com:LAFK_pl/${NAZWA}.git master;;
        * ) echo "mantra: Nani?! Takiego repo nie znam! ${REPO}"; return;;
    esac
}

maven
cat << EOF > readme.adoc
= About $NAZWA
:author: Tomasz @LAFK_pl Borek

$NAZWA :: ?

[TIP]
.To launch / By uruchomić
----

1. Prerequisites / Prerekwizyty: JDK $JDK, Debian or it's derivatives / Debiana lub pochodnej, Maven 3, 
2. Setup: nothing aside from prerequisites / Instalacja: nic więcej niż prerekwizyty
3. \`mvn verify; cd target; java -jar $NAZWA.jar # $NAZWA-versionNumbers.jar\`
----

EOF

repo
idea pom.xml &
pwd | xclip -i
echo mantra: cd Shift Ins
repo_remote
