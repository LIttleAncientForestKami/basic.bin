#!/bin/bash

#4 crontab:
pid=$(pgrep -u $LOGNAME xfce4-session)
xfce_session_env="/proc/$pid/environ"
to_export=$(strings $xfce_session_env | grep DBUS_SESSION_BUS_ADDRESS)
export $to_export
#export "$(grep DBUS_SESSION_BUS_ADDRESS | strings /proc/"$(pgrep -u $LOGNAME xfce4-session)"/environ)"

# Notifications: https://wiki.archlinux.org/index.php/Desktop_notifications
# Icons: https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html
# Po jakimś czasie sprawdź czy libnotify poprawili i czy można nadpisywać notyfikacje
# rozważ zabicie notify-osd kiedyś, by nadpisać notkę

notify-send "${1:-'Bez tematu'}" "${2:-'Bez treści'}" --icon=${3:-gnome-do}
# image-loading gnome-do computer-fail bash application-default-icon
# I="/usr/share/icons/gnome/32x32/status/computer-fail.png"
