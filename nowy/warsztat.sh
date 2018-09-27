#!/bin/bash

#set -x

instrukcja() {
    echo "Skrypt tworzy strukturę do nowego warsztatu. Instrukcja obsługi:"
    echo "$0 nazwaWarsztatu -t TEMAT - tworzy katalog warsztatu (jako podkatalog bieżącego) i robi wstępną robotę, zakładając tytuł warsztatu i folder na bazie TEMATu."
    echo "$0 nazwaWarsztatu [-d | --debug] [-v | --verbose] [-z | --zamawia NAZWA] [-c | --chmura] [-t | --temat TEMAT] [-k | --katalog NAZWA_KATALOGU]"
    exit 1
}

temat-a-katalog() {

    if [[ -z "$t" ]]; then
        echo Nie podano tematu. Nic nie zrobię.
        instrukcja
    elif [[ -z "$k" ]]; then
        echo nieustawiono katalogu, ustawiam z tematu
	    k=$t
    else
        echo "-t/--temat ustawia katalog również, ale ponieważ znalazłem opcję -k/--katalog to tym razem tego nie zrobię (tamte opcje mają precedens)"
	fi

}

if [[ $# -eq 0 ]]; then
    instrukcja
fi

getopt --test > /dev/null
if [[ $? -ne 4 ]]; then
 echo "Nie ma getopt? `getopt --test` nie zwraca 4ki."
     exit 1
fi

opcje=dvz:ct:k:
ooopcjeee=debug,verbose,zamawia:,chmura,temat:,katalog:

PARSED=$(getopt --options=$opcje --longoptions=$ooopcjeee --name "$0" -u -- "$@")
if [[ $? -ne 0 ]]; then
    #  debug: getopt ma złe argumenty
    exit 2
fi
# cudzysłów naokoło argumentów
eval set -- "$PARSED"

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -d|--debug)
            d=y
            shift
            ;;
        -z|--zamawia)
            z=y
	        kto_zleca=$2
            shift 2
            ;;
        -c|--chmura)
            c=y
            shift
            ;;
        -v|--verbose)
            v=y
            shift
            ;;
    	-t|--temat)
	        t=$2
	        shift 2
	        ;;
    	-k|--katalog)
	        k=$2
	        shift 2
	        ;;
        --)
            shift
            break
            ;;
        *)
            echo "Nieprzewidziany tok programu: $1"
            exit 3
            ;;
    esac
done

temat-a-katalog

# odkomentuj dla obsługi parametrów dodatkowych (nie opcji)
#if [[ $# -ne 1 ]]; then
#    echo "$0: wymagany jest pojedynczy plik wejściowy -> czyli coś zostało do sparsowania po sparsowaniu: $#"
#    exit 4
#fi

echo "gadatliwość: $v, zamawia: $kto_zleca, odrobaczanie: $d, chmura: $c, temat: $t, katalog: $k"


cp -r ~/bin/nowy/szkieletSzkolenia "$k"
mv "$k"/x.adoc "$k"/"$t".adoc
mv "$k"/x-docinfo.html "$k"/"$t"-docinfo.html
