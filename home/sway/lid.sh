#!/usr/bin/env bash

if grep -q open /proc/acpi/button/lid/LID0/state; then
  swaymsg output eDP-1 enable
else
  if [ $(swaymsg -pt get_outputs | grep Output | wc -l) -eq "1" ]; then
    [ ! $(pgrep -x "swaylock") ] && swaylock -f -c 000000
  fi
  swaymsg output eDP-1 disable
fi
