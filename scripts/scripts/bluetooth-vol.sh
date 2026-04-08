#!/usr/bin/env bash

bluetooth_device_id=$(pw-dump| jq '.[] | select(.info.props."node.description" == "WH-1000XM4" and .info.props."media.class" == "Audio/Sink") | .info.props."node.driver-id"')

case "$1" in
  up)
    wpctl set-volume "$bluetooth_device_id" 4%+
    ;;
  down)
    wpctl set-volume "$bluetooth_device_id" 4%-
    ;;
  mute)
    wpctl set-mute "$bluetooth_device_id" toggle
    ;;
  *)
    echo "Usage: $0 {up|down|mute}"
    exit 1
    ;;
esac
