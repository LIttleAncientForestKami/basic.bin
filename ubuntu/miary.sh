#!/bin/bash

read -p 'Co przeliczam? ' MIARA
read -p 'Ile tego jest? ' ILE

REZULTAT=0

case "$MIARA" in
    jard) REZULTAT=$(bc <<< "$ILE * 0.9144");;
    stopa) REZULTAT=$(bc <<< "$ILE * 0.3048");;
    *) echo podano $* a ja znam stopy i jardy; exit 1;;
esac
echo $ILE $MIARA na metry: $REZULTAT m

function pomoc() {
    echo "Miary wzięte z porozumienia z 1959r pomiędzy USA i Wspólnotą Narodów. Jard tam został zdefiniowany jako 0,9144 metra. Stąd stopa to 0,3048m."
}

