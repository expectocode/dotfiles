#!/bin/bash
if (( $# > 0 )); then
    sink=$1
    if [[ $sink == "bt" ]]; then
        # parse pactl to get the Bluetooth sink number
        sink=$(pamixer --list-sinks | tail -n1 | cut -c1)
    fi
else
    sink=0
fi

pamixer --sink "$sink" --toggle-mute

volume=$(pamixer --sink "$sink" --get-volume)
mute=$(pamixer --sink "$sink" --get-mute)

mplayer /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga

[[ $mute == "true" ]] && muted="(m)" || muted=""
if [[ "$sink" == 0 ]]; then
    notify-send "$volume $muted"
else
    notify-send "$volume $muted" "$sink"
fi
