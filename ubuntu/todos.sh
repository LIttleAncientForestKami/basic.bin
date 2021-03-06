#!/bin/bash
# Author: LAFK_pl, TJB
# RDZ: może prosty ADOC albo lista jakaś, by widać było że w pliku X tyle a w pliku Z tyle; ilość wszystkich TODO -> statystyki

# SED study:
# https://www.gnu.org/software/sed/manual/html_node/Joining-lines.html
# https://superuser.com/questions/1331719/how-to-concatenate-two-lines-with-sed
# https://superuser.com/questions/1333067/remove-every-line-breaks-following-carriage-return-m-and-join-the-lines/1333129#1333129

mvn taglist:taglist -q
REPORT_FILE="target/taglist/taglist.xml"
grep -E "<file name|lineNum|comment[>]\w" $REPORT_FILE > rez
sed -i "s/<file name=//" rez
sed -i "s/<comment>//" rez
sed -i "s/<lineNumber>/line /" rez
sed -i "s/<\/lineNumber>/;/" rez
sed -i 's/"//g' rez
sed -i "s/ count=2>//" rez
sed -i "s/;$/;/" rez
sed -i "s/^[ \t]*//" rez
sed -i 's/<.comment>//' rez
paste -sd '#' rez | sed 's/;#/; /g;s/#/\n/g' > TODO_comments_found
batcat TODO_comments_found
rm rez TODO_comments_found
