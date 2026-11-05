#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

selected=$(
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname '*.jpg' \
        -o -iname '*.jpeg' \
        -o -iname '*.png' \
        -o -iname '*.webp' \) |
    sort |
    while IFS= read -r file; do
        printf '%s\0icon\x1f%s\n' \
            "$(basename "$file")" "$file"
    done |
    fuzzel --dmenu --hide-prompt
)

[[ -z "$selected" ]] && exit 0

awww img \
    --all \
    --resize crop \
    --transition-type random \
    --transition-duration 1 \
    "$WALLPAPER_DIR/$selected"
    
ln -sf "$WALLPAPER_DIR/$selected" "$HOME/.cache/current-wallpaper"