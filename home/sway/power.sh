#!/usr/bin/env bash

set -e
set -o pipefail

ACTION=$(echo -e "poweroff\nreboot\nsuspend" | wofi --dmenu --insensitive --prompt "systemctl")
systemctl $ACTION
