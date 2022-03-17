#!/usr/bin/env bash

set -euo pipefail

if [ $# -eq 0 ]; then
  ACTION=$(echo -e "poweroff\nreboot\nsuspend\nlock" | bemenu --ignorecase --prompt "Choose action" --fn "Fira Code" --tb "#285577" --hb "#285577" --tf "#eeeeee" --hf "#eeeeee" --nf "#bbbbbb")
else
  ACTION=$1
fi

case $ACTION in
  "lock")
    [ ! $(pgrep -x "swaylock") ] && swaylock -f -c 000000;;
  *) systemctl $ACTION;;
esac
