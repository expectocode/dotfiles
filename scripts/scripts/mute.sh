#!/bin/bash

pamixer --toggle-mute

volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

mplayer /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga

[[ $mute == "true" ]] && muted="(m)" || muted=""
notify-send "$volume $muted"
