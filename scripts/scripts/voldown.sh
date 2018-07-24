#!/bin/bash
# VOLUME=$($pamixer --get-volume)
pamixer --decrease 2
mplayer /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
