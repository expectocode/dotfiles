#!/bin/sh
#
# resize windows with bspwm
#
# wm key bindings

percent=2

# set a smaller percentage when floating
bspc query -N -n focused.floating > /dev/null && percent=1

case $1 in
    west)  dir=right; falldir=left; sign=-;;
    east)  dir=right; falldir=left; sign=+;;
    north) dir=bottom; falldir=top; sign=-;;
    south) dir=bottom; falldir=top; sign=+
esac

# get a percentage of the monitor horizontal resolution
var=$((`bspc query -T -m | jq .rectangle.width` * percent / 100))

[ "$dir" = right ] && { x="$sign$var"; y=0; }
[ "$dir" = bottom ] && { y="$sign$var"; x=0; }

# try to resize in one direction
# fallback to the other if it fails
bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y"
