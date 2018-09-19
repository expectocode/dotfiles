#!/usr/bin/env bash
if [[ $1 == "slopclip" ]]; then
	sel=$(slop -f "-i %i -g %g")
	shotgun $sel - | xclip -t 'image/png' -selection clipboard
else
	file=$(mktemp /tmp/XXXXX.png)
	shotgun "$file" && gimp "$file"
	# sleep 0.2
	# scrot $file
fi
