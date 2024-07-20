#!/usr/bin/env bash
# Autor: Tomasz LAFK_pl Borek
# Inspiracja: d0x z SO (https://stackoverflow.com/users/1199731/d0x), uprzejmie mówiący jak w IntelliJu dodać słownik by nie mieć nieskończonych komunikatów o literówkach
# Inne słowniki: https://cgit.freedesktop.org/libreoffice/dictionaries/plain/  czy https://www.winedt.org/dict.html
URL_PL="https://www.winedt.org/dict/Polish_huge.zip"
printf "Pobiera słownik języka polskiego z witryny winedt.org. Wymaga 'curl'a i 'unzip'a by pobrać słownik i sudo by wrzucić go do /usr/share\n"
set -ex

curl $URL_PL --output słownik.zip
unzip słownik.zip
sudo mv pl_huge.dic /usr/share/
rm słownik.zip
