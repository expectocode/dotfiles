#!/usr/bin/env bash
max=$(< /sys/class/backlight/intel_backlight/max_brightness)

# run once
brightness=$(< /sys/class/backlight/intel_backlight/brightness)
percentage=$(bc <<< "$brightness * 100 / $max")
echo -e "\uE1AC $percentage";

while read -r events; do
    brightness=$(< /sys/class/backlight/intel_backlight/brightness)
    percentage=$(bc <<< "$brightness * 100 / $max")
    echo -e "\uE1AC $percentage";
done < <(inotifywait -q -m -e close_write --format %e /sys/class/backlight/intel_backlight/brightness)
