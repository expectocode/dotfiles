#!/bin/sh
#
# move windows with bspwm
#
# wm key bindings

percent=5

# also move floating windows
if bspc query -N -n focused.floating > /dev/null; then
    case $1 in
        west)  target=x; sign=-;;
        east)  target=x; sign=+;;
        north) target=y; sign=-;;
        south) target=y; sign=+
    esac

    # get a percentage of the monitor horizontal resolution
    var=$((`bspc query -T -m | jq .rectangle.width` * percent / 100))

    [ "$target" = x ] && { x="$sign$var"; y=0; }
    [ "$target" = y ] && { y="$sign$var"; x=0; }

    bspc node -v "$x" "$y"
else
    # teleport cursor on the focused window
    bspc config pointer_follows_focus true
    bspc node -s "$1"
    bspc config pointer_follows_focus false
fi
