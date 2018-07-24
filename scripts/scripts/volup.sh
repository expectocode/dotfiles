#!/bin/bash
# VOLUME=$($pamixer --get-volume)
pamixer --increase 2
mplayer /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
