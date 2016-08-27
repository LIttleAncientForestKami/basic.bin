#!/bin/bash

NOTIFY=/home/tammo/bin/notify.sh
FOLDER=/home/tammo/Obrazy/DPR_dziś
cd $FOLDER

# for xprintidle and scrot
export DISPLAY=:0.0

IDLE_MINUTES=$(expr $(xprintidle) / 1000 / 60)

if [ $IDLE_MINUTES -le 14 ]; then
    $NOTIFY "Zrzut ekranu" "z $(date)" insert-image
    scrot '%Y-%m-%d %H:%M.png' -q 20
else
    $NOTIFY "Zrzut zatrzymany" "Bezczynnie minut: $IDLE_MINUTES" user-idle
fi

# http://manpages.ubuntu.com/manpages/dapper/man5/timeouts.5.html
# http://ubuntuforums.org/showthread.php?t=1791014
# https://github.com/gpolitis/shoot/blob/master/bin/shoot
