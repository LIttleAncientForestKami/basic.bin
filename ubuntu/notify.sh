#!/bin/bash

# Notifications: https://wiki.archlinux.org/index.php/Desktop_notifications
# Icons: https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html

notify-send "${1:-'Bez tematu'}" "${2:-'Bez treści'}" --icon=${3:-image-loading}
