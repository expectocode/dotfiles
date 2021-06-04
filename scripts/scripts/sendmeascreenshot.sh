#!/usr/bin/env bash
file=$(mktemp /tmp/XXXXX.png) &&
~/.cargo/bin/shotgun "$file" &&
~/bin/telegram-send -f "$file" &&
rm "$file"
