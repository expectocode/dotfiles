# A long-running script to print MPD updates for the bar

music(){
    song=$(playerctl metadata --format "{{ title }} · {{ artist }}")

    sstatus=$(playerctl status | grep -E "(Playing|Paused)" -o)
    if [ "$sstatus" == "Playing" ]; then
        echo play
        icon='\uE034'
    else
        echo pause
        icon='\uE037'
    fi

    if [ -z "$song" ]; then #if empty
        fil=$(mpc current -f '%file%')
        song="${fil##*/}"
        # lmao does this work
        if [[ -z "$song" ]]; then # if still empty
            song=$(for nid in $(bspc query -N -d $(bspc query -D -d '^9') -n .window); do
                xdotool getwindowname "$nid"
            done | rg '·.+Firefox' | tail -n1 | sed 's/ - Mozilla Firefox//')

            icon='\uE034'
        fi
    fi


    echo -e "%{A:timeout 0.3 playerctl play-pause:}$icon $song %{A}"
}

{ playerctl status --follow & playerctl metadata --follow; } | while read _ ; do
    music
done
