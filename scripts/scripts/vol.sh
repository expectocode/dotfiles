#!/usr/bin/env bash
default_sink=$(pamixer --list-sinks | head -n2 | tail -n1 | cut -c1)

if (( $# > 0 )); then
    sink=$1
    if [[ $sink == "bt" ]]; then
        # parse pactl to get the Bluetooth sink number
        sink=$(pamixer --list-sinks | tail -n1 | cut -d' ' -f1)
    fi
else
    sink="$default_sink"
fi

muted=$(pamixer --sink "$sink" --get-mute |
        grep true >/dev/null &&
            echo "muted" ||
            echo "not muted")

if [[ "$sink" == "$default_sink" ]]; then
    notify-send "$(pamixer --sink "$sink" --get-volume)" "$muted"
else
    notify-send "$(pamixer --sink "$sink" --get-volume)" "$sink, $muted"
fi
