#!/usr/bin/env bash
if (( $# > 0 )); then
    sink=$1
    if [[ $sink == "bt" ]]; then
        # parse pactl to get the Bluetooth sink number
        sink=$(pamixer --list-sinks | tail -n1 | cut -c1)
    fi
else
    sink=0
fi

muted=$(pamixer --sink "$sink" --get-mute |
        grep true >/dev/null &&
            echo "muted" ||
            echo "not muted")

if [[ "$sink" == 0 ]]; then
    notify-send "$(pamixer --sink "$sink" --get-volume)" "$muted"
else
    notify-send "$(pamixer --sink "$sink" --get-volume)" "$sink, $muted"
fi
