#!/usr/bin/env bash

set -euo pipefail

BRIGHTNESS=$(brightnessctl -m i | cut -d "," -f 4)
BRIGHTNESS=${BRIGHTNESS::-1}

case "$1" in
  "up") 
    if [ $BRIGHTNESS -ge 20 ]; then
      brightnessctl -q s +5%
    else
      brightnessctl -q s +1%
    fi
    ;;
  "down")
    if [ $BRIGHTNESS -gt 20 ]; then
      brightnessctl -q s 5%-
    elif [ $BRIGHTNESS -gt 1 ]; then
      brightnessctl -q s 1%-
    fi
    ;;
esac
