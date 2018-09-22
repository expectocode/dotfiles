#!/usr/bin/env bash

mapfile -t panel_ids < <( xdo id -a lemonpanel )
bspc subscribe node_state| while read _ a b wid action state; do
    for panel_id in "${panel_ids[@]}"; do
        [ $action = "fullscreen" -a $state = "on" ] && xdo below -t $wid $panel_id
    done
done
