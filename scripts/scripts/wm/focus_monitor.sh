#!/bin/sh
#
# focus windows with bspwm
#
# wm key bindings

# teleport cursor on the focused window
bspc config pointer_follows_focus true
bspc monitor -f next
bspc config pointer_follows_focus false
