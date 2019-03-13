#!/usr/bin/env bash
if [[ $1 == "selectclip" ]]; then
	sel=$(hacksaw)
	shotgun -g "$sel" - | xclip -t 'image/png' -selection clipboard
else
	file=$(mktemp /tmp/XXXXX.png)
	shotgun "$file" && gimp "$file"
fi
