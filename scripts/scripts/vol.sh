#!/usr/bin/env bash
muted=$(pamixer --get-mute|grep true >/dev/null && echo "muted" || echo "not muted")
notify-send "$(pamixer --get-volume)" "$muted"
