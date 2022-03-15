#!/usr/bin/env bash

set -euo pipefail

if [ $# -eq 0 ]; then
  ACTION=$(echo -e "poweroff\nreboot\nsuspend\nlock" | wofi --dmenu --insensitive --prompt "Choose action")
else
  ACTION=$1
fi

case $ACTION in
  "lock")
    [ ! $(pgrep -x "swaylock") ] && swaylock -f -c 000000;;
  *) systemctl $ACTION;;
esac
