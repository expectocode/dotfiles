# A long-running script to print MPD updates for the bar

music(){
	song=$(mpc current -f "%artist% - %title%")

	if [ -z "$song" ]; then #if empty
		fil=$(mpc current -f '%file%')
		song="${fil##*/}"
		# lmao does this work
        if [[ -z "$song" ]]; then # if still empty
            song=$(for nid in $(bspc query -N -d $(bspc query -D -d '^9') -n .window); do
                xdotool getwindowname "$nid"
            done | rg '·.+Firefox' | tail -n1 | sed 's/ - Mozilla Firefox//')
        fi
	fi
	# song=$(echo $song | cut -d "(" -f 1) #cut out anything following a (
	# song+=" - "$(mpc current -f %artist%) #add the - artist bit

	mpcstatus=$(mpc status | grep -E "(playing|paused)" -o)
	if [ "$mpcstatus" == "playing" ]; then
		icon='\uE034'
	else
		icon='\uE037'
	fi

	echo -e "%{A:mpc -q toggle:}$icon $song %{A}"
}

music
while :; do
	mpc idle
	music
done
