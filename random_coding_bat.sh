#!/bin/bash
category=${1:-"Warmup-2"}
echo Category is $category - Warmup-2 is the default

function pullTask() {
    curl https://codingbat.com/java/"$category"\?chance=1 -L | grep max2 > p.html
    firefox CodingBatRandomTask.html
}

function categories() {
    echo Warmup-[12], Array-[123], Map-[12], Functional-[12], Logic-[12], String-[123], Recursion-[12], AP-1
}

categories
pullTask
