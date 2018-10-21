#!/bin/bash

for b in $(git branch -r); do 
    ILE=$(git log --oneline | wc -l)
    notify-send $b $ILE
    sleep 3
done
