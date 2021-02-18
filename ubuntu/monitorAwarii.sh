#!/bin/bash
# Author: TJB, LAFK_PL
# Idea behind: UpdateNotifier does a lot, and when it spots a crash it merely asks "should I report it?"
# It doesn't however tell me WHAT crashed. So, here I have a script, installed in crontab and running every minute, checking what crashed in the last minute. It reports a single thing though.
# URLs: https://wiki.ubuntu.com/UpdateNotifier
#       https://www.maketecheasier.com/fix-ubuntu-update-errors/

RUN_PATH=$(dirname $0)

notify() {
    /home/tammo/bin/ubuntu/notify.sh $1 $2
}

compare() {
    find /var/crash -amin -1
#    touch .monitorAwarii_compareRefTime
}

REZ=$(compare | tail -1)

[[ $(compare | wc -l) -gt 1 ]] && notify "Awarie(a?)" "$REZ" || echo "OK" 
