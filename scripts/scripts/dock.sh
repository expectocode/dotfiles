set -xuo pipefail
## Reset
xrandr --output DP-1-2-8 --off --output DP-1-1 --off --output DP-2 --off --output eDP-1 --primary --mode 1920x1080 --rotate normal --output DP-1 --off; bspc monitor DP-2 --remove; bspc monitor DP-1 --remove; bspc monitor DP-1-2-8 --remove; bspc monitor DP-1-1 --remove; bspc monitor eDP-1 --reset-desktops $(seq 1 20); { feh --bg-scale ~/Pictures/eighties-bg-alphabet-1440p.png && killall lemonbar; ~/scripts/lemonbar/bar_run & } && bspc wm --adopt-orphans && systemctl --user restart compositor& xdo lower -ma "lemonpanel" && xdo lower -a "eDP-1" && xdo lower -a "DP-2"

## New
~/.screenlayout/dock.sh &&
    bspc monitor DP-1-2-8 --reset-desktops $(seq 1 10) &&
    bspc monitor DP-1-1 --reset-desktops $(seq 11 11) &&
    bspc monitor eDP-1 --reset-desktops $(seq 12 12) &&
    feh --bg-scale ~/Pictures/eighties-bg-alphabet-1440p.png &&
    killall lemonbar &&
    sleep 2 &&
~/scripts/lemonbar/bar_run &
~/scripts/kblayouts.sh &&
systemctl --user restart compositor &&
xdo lower -ma "lemonpanel" && xdo lower -a "eDP-1" && xdo lower -a "DP-2" &&
bspc config bottom_padding 30
