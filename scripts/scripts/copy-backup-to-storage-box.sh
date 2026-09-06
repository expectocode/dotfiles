#!/usr/bin/env bash
set -euo pipefail

# leave off the trailing slash
repo=/run/media/tanuj/backups/Xps
sbox=sbox-borg
dest=./laptop-backup

case "${1:-}" in
  "") dry=() ;;
  -n|--dry-run) dry=(--dry-run --itemize-changes) ;;
  *) echo "usage: $0 [--dry-run]"; exit 1 ;;
esac

[[ -f $repo/config && -d $repo/data ]] || { echo "$repo isn't a borg repo"; exit 1; }
[[ ! -e $repo/lock.exclusive ]] || { echo "repo locked, is vorta still running?"; exit 1; }

ssh "$sbox" mkdir -p "$(dirname "$dest")"

# --times is important for rsync dedup
rsync "${dry[@]}" \
    --recursive --links --times --verbose \
    --delete-after \
    --partial-dir=.rsync-partial \
    --exclude=lock.exclusive --exclude=lock.roster \
    --timeout=300 \
    --info=progress2 --human-readable --stats \
    --rsh=ssh \
    "$repo/" "$sbox:$dest/"
