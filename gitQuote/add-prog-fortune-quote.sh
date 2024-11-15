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

FORTUNE_PATH=/usr/share/games/fortunes

TXT=${1:-"/home/$(whoami)/Kod/basic.bin/gitQuote/"}prQ # this file is in Git, so we want to keep it up to date

echo Location of prQ file is:  $TXT. 
echo If you want to change run - $(basename $0) /your/location/ - end with /, do NOT add prQ

DAT=prQ.dat

echo "Assuming fortune located in $FORTUNE_PATH, file with quotes being prQ and you being in sudoers. Licence GPLv3."
echo "Quote text please?"
read QUOTE
echo "Author?"
read AUTHOR

echo "$QUOTE 
    -- $AUTHOR 
%
" >> $TXT
sudo strfile -c % $TXT $DAT
echo Installing files to $FORTUNE_PATH
sudo cp prQ* $FORTUNE_PATH
