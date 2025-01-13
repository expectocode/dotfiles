#!/bin/bash
export QT_QPA_PLATFORMTHEME=qgnomeplatform


# Switch to tg if it's open (then exit script)

for desktop in $(bspc query -D); do
    for nid in $(bspc query -N -d "$desktop" -n .window); do
        case $(xtitle "$nid") in
            *"Telegram ("*)
                bspc desktop "$desktop" -f
                bspc node -f "$nid"
                exit
        esac
    done
done

~/.nix-profile/bin/telegram-desktop "$@"
