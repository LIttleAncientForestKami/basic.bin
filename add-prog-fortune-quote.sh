#!/bin/bash

########################################################################
# add-prog-fortune-quote - adds new quotations and converts file to .dat
########################################################################
#  Copyright (C) {2012}  {Tomasz Borek}
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#######################################################################

FORTUNE_PATH=.
# /usr/share/games/fortune

TXT=$FORTUNE_PATH/prQ
DAT=$FORTUNE_PATH/prQ.dat

echo "Assuming fortune located in $FORTUNE_PATH, and file with quotes being prQ"
echo "Quote text please?"
read QUOTE
echo "Author?"
read AUTHOR

echo "%
$QUOTE 
		 -- $AUTHOR 
" >> $TXT
strfile -c % $TXT $DAT
