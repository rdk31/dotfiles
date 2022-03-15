#!/usr/bin/env bash

set -euo pipefail

ACTION=$(echo -e "poweroff\nreboot\nsuspend" | wofi --dmenu --insensitive --prompt "systemctl")
systemctl $ACTION
