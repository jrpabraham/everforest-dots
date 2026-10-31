#!/bin/bash

STEP=5

case "$1" in
  up)   brightnessctl -q set "${STEP}%+" ;;
  down) brightnessctl -q set "${STEP}%-" ;;
  *)    exit 1 ;;
esac

level=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

notify-send -a Brightness \
  -h "int:value:${level}" \
  -h string:x-canonical-private-synchronous:brightness \
  " "