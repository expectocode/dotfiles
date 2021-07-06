#!/bin/bash
default_sink=$(pamixer --list-sinks | head -n2 | tail -n1 | cut -d' ' -f1)

if (( $# > 0 )); then
    sink=$1
    if [[ $sink == "bt" ]]; then
        # parse pactl to get the Bluetooth sink number
        sink=$(pamixer --list-sinks | tail -n1 | cut -d' ' -f1)
    fi
else
    sink="$default_sink"
fi

pamixer --sink "$sink" --increase 2
mplayer -ao pulse::"$sink" /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
