#!/usr/bin/env bash
# print battery info

# Turn "Battery 0: Discharging, 18%, 01:16:05 remaining" into "Discharging 18% 1:16"
mapfile -t battery < <(acpi | awk '{print $3, $4, $5}'|sed "s/,//g; s/ 0/ /g; s/:..$//"| tr " " "\n")
# seds: remove commas, leading zeros, and seconds
# then replace spaces with newlines for easy arrayification
status=${battery[0]}
percent=${battery[1]}
time=${battery[2]}

if [ "$status" == "Charging" ]; then
	# charging
	icon='\uE1A3'
elif [[ ${percent::-1} -gt 20 ]]; then
	# discharging, not low
	icon='\uE1A4'
else
	# discharging, low
	icon='\uE19C'
fi

echo -e "$icon" "$percent" "($time)"
