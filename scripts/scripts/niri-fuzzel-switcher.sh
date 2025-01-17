#!/bin/bash

window_ids=()
window_titles=()

cur_workspace=$(niri msg --json workspaces | jq '.[] | select(.is_focused) | .id')

while read i; do
  declare -a line_array="($i)"
  window_ids+=(${line_array[0]})
  window_titles+=("${line_array[1]} - ${line_array[2]} \0icon\x1f${line_array[1]}")
done <<<$(niri msg --json windows | jq -r '.[] | select(.workspace_id == '"$cur_workspace"') | [ .id, .title] | "\""+join ("\" \"")+"\""')

result=$(
    printf "%b\n" "${window_titles[@]}" | fuzzel \
        --width 100 \
        --use-bold \
        --font Hack-14 \
        --no-sort \
        --background 2d2d2dff \
        --text-color d3d0c8ff \
        --border-color 505050ff \
        --border-width 2 \
        --counter \
        --dmenu \
        --index
)

if [ "x$result" != "x" ] && [ $result != -1 ]; then
  niri msg action focus-window --id ${window_ids[result]}
fi
