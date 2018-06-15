#!/bin/bash

set -x

getopt --test > /dev/null
if [[ $? -ne 4 ]]; then
 echo "Nie ma getopt? `getopt --test` nie zwraca 4ki."
     exit 1
fi

opcje=dvz:c
ooopcjeee=debug,verbose,zamawia:,chmura

PARSED=$(getopt --options=$opcje --longoptions=$ooopcjeee --name "$0" -- "$@")
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
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

# handle non-option arguments
if [[ $# -ne 1 ]]; then
    echo "$0: A single input file is required."
    exit 4
fi

echo "verbose: $v, zamawia: $kto_zleca, debug: $d, chmura: $c, nazwa: $1"



#echo "$0 nazwaWarsztatu - tworzy katalog warsztatu (jako podkatalog bieżącego) i robi wstępną robotę."
#cp -r /home/tammo/bin/nowy/szkieletSzkolenia $1
