#!/bin/bash

# ps obtains LWP ID and CPU usage %
# sort by 2nd key, (g)eneral numeric
# uniq to cut dupes (ignoring 1st col) 
threadsPlease() {
  ps -mo lwp,c -p $1 | sort -gk 2 | uniq -f 1 
}

# cut last line, it's process overall
# display 2nd to last line, it's most CPU intensive thread
THREAD_LINE=$( threadsPlease $1 | grep -v - | tail -1)

echo $THREAD_LINE
exit
THREAD10=$(echo $THREAD_LINE | awk '{print $1}')
THREAD16=$(printf '%x\n' $THREAD10)

JAVA_LINE=$(jstack $1 | grep $THREAD16)
echo "OS data (thread, CPU usage %): " $THREAD_LINE
echo "Java thread: " $JAVA_LINE
