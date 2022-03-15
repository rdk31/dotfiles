#!/usr/bin/env bash

set -euo pipefail

ac() {
  grep -q 1 /sys/class/power_supply/AC/online
}

pulse() {
  pactl list | grep -q RUNNING
}

case "$1" in
  "lock")
    if ! pulse; then
      ./power.sh lock
    fi
    ;;
  "screen") 
    if ! pulse; then
      swaymsg "output * dpms off"
    fi
    ;;
  "suspend") 
    if ! (ac || pulse); then
      swaymsg "output * dpms on"
      systemctl suspend
    fi
    ;;
esac
