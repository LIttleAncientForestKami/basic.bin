#!/bin/bash
function sort() {
    for i in "$@"
    do
        sleep $i && echo $i &
    done
}

if [[ $# == 0 ]]; then
    sort 8 5 2 1
else
    sort "$@"
fi
wait

