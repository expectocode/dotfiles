#!/bin/bash
export QT_QPA_PLATFORMTHEME=qgnomeplatform


tg_id=$(niri msg -j windows | jq '.[] | select(.app_id == "org.telegram.desktop") | .id')
if [[ ! -z "$tg_id" ]]; then
    niri msg action focus-window --id "$tg_id"
    exit
fi

~/.nix-profile/bin/Telegram "$@"
