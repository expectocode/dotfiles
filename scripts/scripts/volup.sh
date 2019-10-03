#!/bin/bash
# VOLUME=$($pamixer --get-volume)
if (( $# > 0 )); then
    sink=$1
    if [[ $sink == "bt" ]]; then
        # parse pactl to get the Bluetooth sink number
        sink=$(pamixer --list-sinks | tail -n1 | cut -c1)
    fi
else
    sink=0
fi

pamixer --sink "$sink" --increase 2
mplayer -ao pulse::"$sink" /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
