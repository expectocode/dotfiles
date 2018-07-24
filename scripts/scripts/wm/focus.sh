#!/bin/sh
#
# focus windows with bspwm
#
# wm key bindings

bspc query -N -n "$1" > /dev/null || exit
# exit when nothing in specified direction

# teleport cursor on the focused window
bspc config pointer_follows_focus true
bspc node -f "$1".local
bspc config pointer_follows_focus false
