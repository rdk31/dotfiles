#!/usr/bin/env bash

set -euo pipefail

OPTIONS="mf - monitor file\nmc - monitor clipboard\nwf - window file\nwc - window clipboard\nrf - region file\nrc - region clipboard"

if [ $# -eq 0 ]; then
  OPTION=$(echo -e "$OPTIONS" | bemenu --list 10 --ignorecase --prompt "Screenshot mode" --fn "Fira Code" --tb "#285577" --hb "#285577" --tf "#eeeeee" --hf "#eeeeee" --nf "#bbbbbb" | cut -d" " -f 1)
else
  OPTION=$1
fi

DATE=$(date +'%Y-%m-%d-%T')
FILE="$HOME/Pictures/$DATE.png"

case "$OPTION" in
  "mf") grimshot --notify save output $FILE;;
  "mc") grimshot --notify copy output;;
  "wf") grimshot --notify save active $FILE;;
  "wc") grimshot --notify copy active;;
  "rf") grimshot --notify save area $FILE;;
  "rc") grimshot --notify copy area;;
esac
