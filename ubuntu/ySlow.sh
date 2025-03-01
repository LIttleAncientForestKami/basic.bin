#!/bin/bash

# LAFK_pl
# why my net is slow? with curl, thanks to Binoy Babu from AskUbuntu

function debug() {
    echo checking $1
    echo $(dirname $0)
    curl -w @/home/lafk/Kod/basic.bin/ubuntu/netDebug.conf -o /dev/null -s $1
}

debug $1
echo compare...
debug google.com


