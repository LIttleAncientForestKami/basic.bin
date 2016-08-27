#!/bin/bash

# Credits: http://plankenau.com/blog/post/gaussian-blur-lock-screen-i3lock/
# I've added text on top of screenshot.
# Also, use autolock in xsession.rc file:
## auto locks screen with my locker
#xautolock -time 10 -locker lock.sh

MSG=${@:-"AFK ATM"}

scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
convert /tmp/screenshotblur.png -gravity Center -background YellowGreen -splice 0x48 -annotate +0+2 "$MSG" /tmp/screenshotblur.png
i3lock -i /tmp/screenshotblur.png
