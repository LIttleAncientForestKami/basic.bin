#!/bin/bash

FOLDER=/media/Mmedia/zrzuty/
cd $FOLDER

# for xprintidle and scrot
export DISPLAY=:0.0

IDLE_MINUTES=$(expr $(xprintidle) / 1000 / 60)

echo "Zrzut ekranu z $(date) "
if [ $IDLE_MINUTES -le 14 ]; then
scrot '%Y-%m-%d %H:%M.png' -q 20
echo " do $FOLDER."
else
echo " zatrzymany. Bezczynnie minut: $IDLE_MINUTES"
fi

# http://manpages.ubuntu.com/manpages/dapper/man5/timeouts.5.html
# http://ubuntuforums.org/showthread.php?t=1791014
# https://github.com/gpolitis/shoot/blob/master/bin/shoot
