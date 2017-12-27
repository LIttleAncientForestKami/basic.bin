#!/bin/bash
for i in 8 2 5 1
do
    sleep $i && echo $i &
done

