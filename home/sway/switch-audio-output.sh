#!/usr/bin/env bash

set -euo pipefail

SINKS=$(pactl list sinks | sed -En "s/^.*Description\: //p")
NEW_SINK_DESCRIPTION=$(echo "$SINKS" | bemenu --list 10 --ignorecase --prompt "Choose output sink" --fn "Fira Code" --tb "#285577" --hb "#285577" --tf "#eeeeee" --hf "#eeeeee" --nf "#bbbbbb")
NEW_SINK_NAME=$(pactl list sinks | grep -m 1 -B 1 "$NEW_SINK_DESCRIPTION" | sed -En "s/^.*Name\: //p")
pactl set-default-sink "$NEW_SINK_NAME"

SINK_INPUTS=$(pactl list short sink-inputs | egrep -o '^[0-9]+')
for SINK_INPUT in ${SINK_INPUTS[*]}; do 
  pactl move-sink-input $SINK_INPUT $NEW_SINK_NAME; 
done
