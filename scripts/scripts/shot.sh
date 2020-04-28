#!/usr/bin/env bash
if [[ $1 == "selectclip" ]]; then
	sel=$(hacksaw)
	shotgun -g "$sel" - | xclip -t 'image/png' -selection clipboard
elif [[ $1 == "freeze" ]]; then
    shotgun - | pqiv -ic -z 1.000000001 - &
    pid=$!
    geom=$(hacksaw)
    shotgun -g $geom - | xclip -selection clipboard -t "image/png"
    kill $pid
else
	file=$(mktemp /tmp/XXXXX.png)
	shotgun "$file" && gimp "$file"
fi
