#!/bin/bash

OBRAZEK=${1:-"cover_?.jpg"}
URL=${2:-"http://bit.ly/??"}
cat << EOF
[cols="1a,1a"]
|===
|
image::$1[640,480]
|
. $2
. a
. b
. c
|===
EOF
