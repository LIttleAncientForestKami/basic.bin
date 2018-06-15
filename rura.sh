#!/bin/bash
for ((i=0; i<100; i++)); do
    cat >file <<-EOF
    foo
    bar
EOF
    cat file |
        sed 's/bar/baz/' |
        tee file >/dev/null
    [ -s file ] &&
        echo 'Not truncated' ||
        echo 'Truncated'
done |
    sort |
    uniq -c
rm file
