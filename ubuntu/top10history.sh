#!/bin/bash
# drukuje 10 najpopularniejszych komend w historii
# zsh z datą i godziną historii - stąd 4 kolumna
#set -x
history | awk '{print $4}' | sort | uniq -c | sort -g | tail
