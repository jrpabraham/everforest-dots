#!/bin/bash

case "$1" in
    up)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(awk '{printf "%d", $2 * 100}' <<< "$info")

if [[ "$info" == *"[MUTED]"* ]]; then
    notify-send \
        -a "Volume" \
        -h string:x-canonical-private-synchronous:volume \
        -h int:value:0 \
        ""
else
    notify-send \
        -a "Volume" \
        -h string:x-canonical-private-synchronous:volume \
        -h int:value:"$volume" \
        ""
fi
