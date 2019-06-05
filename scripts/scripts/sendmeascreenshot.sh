#!/usr/bin/env bash
file=$(mktemp /tmp/XXXXX.png) &&
~/.cargo/bin/shotgun "$file" &&
telegram-send -f "$file" &&
rm "$file"
