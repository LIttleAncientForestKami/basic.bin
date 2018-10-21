#!/bin/bash
set -e
REPO=${1:-$(pwd)}
echo $REPO
git fetch --all
for b in $(git branch -r); do 
    git co ${b##origin/}
done
git pull --tags
I="/usr/share/icons/gnome/32x32/status/computer-fail.png"
I_DO="gnome-do"
notify-send $0 "$REPO uaktualnione" --icon=$I_DO
