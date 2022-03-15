#!/usr/bin/env bash

set -euo pipefail

OPTIONS="mf - monitor file\nmc - monitor clipboard\nwf - window file\nwc - window clipboard\nrf - region file\nrc - region clipboard"

if [ $# -eq 0 ]; then
  OPTION=$(echo -e "$OPTIONS" | wofi --dmenu --insensitive --prompt "Screenshot mode" | cut -d" " -f 1)
else
  OPTION=$1
fi

DATE=$(date +'%Y-%m-%d-%T')

case "$OPTION" in
  "mf") grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') "$HOME/Pictures/$DATE.png";;
  "mc") grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | wl-copy -t image/png;;
  "wf") grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$HOME/Pictures/$DATE.png";;
  "wc") grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | wl-copy -t image/png;;
  "rf") slurp | grim -g - "$HOME/Pictures/$DATE.png";;
  "rc") slurp | grim -g - - | wl-copy -t image/png;;
esac
