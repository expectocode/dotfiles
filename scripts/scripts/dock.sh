~/.screenlayout/dock.sh &&
    bspc monitor DP-1-2 --reset-desktops $(seq 1 10) &&
    bspc monitor eDP-1 --reset-desktops $(seq 11 20) &&
    feh --bg-scale ~/Pictures/europe_gmap.png &&
    killall lemonbar;
~/scripts/lemonbar/bar_run &
~/scripts/kblayouts.sh &&
    systemctl --user restart compositor
bspc config bottom_padding 30
