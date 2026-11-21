#!/bin/bash

files() {
  sel=$(fd --hidden --follow \
          --exclude .git --exclude node_modules --exclude .cache \
          . "$HOME" 2>/dev/null \
        | sed "s|^$HOME/|~/|" \
        | rofi -dmenu -i -matching fuzzy -sort -sorting-method fzf -p "open" -theme-str 'window {width: 64ch;}') || return 1
  [ -z "$sel" ] && return 1
  setsid xdg-open "${sel/#\~/$HOME}" >/dev/null 2>&1 &
}

wallpapers() {
  local dir="$HOME/Pictures/Wallpapers"
  local thumbs="$HOME/.cache/wallpaper-thumbs"
  mkdir -p "$thumbs"
  pgrep -x awww-daemon >/dev/null || { awww-daemon & sleep 1; }

  selected=$(
    find "$dir" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) |
    sort |
    while IFS= read -r file; do
      name=$(basename "$file")
      thumb="$thumbs/$name.png"
      [ "$thumb" -nt "$file" ] ||
        magick "$file" -thumbnail 400x225^ -gravity center -extent 400x225 "$thumb" 2>/dev/null
      printf '%s\0icon\x1f%s\n' "$name" "$thumb"
    done |
    rofi -dmenu -show-icons -i -no-custom -p "" \
         -theme-str 'window {width: 900px;}
                     inputbar {enabled: false;}
                     listview {columns: 3; lines: 1; spacing: 0px;}
                     element {orientation: vertical; padding: 8px; spacing: 0px;}
                     element-icon {size: 8em;}
                     element-text {enabled: false;}'
  ) || return 1
  [ -z "$selected" ] && return 1

  awww img --all --resize stretch \
       --transition-type random --transition-duration 1 \
       "$dir/$selected"
  ln -sf "$dir/$selected" "$HOME/.cache/current-wallpaper"
}

system() {
  choice=$(printf ' Lock\n󰤄 Suspend\n󰑙 Reboot\n Shutdown' \
           | rofi -dmenu -i -no-custom -p "System" -theme-str 'window {width: 24ch;} inputbar {enabled: false;} listview {lines: 4;}') || return 1
  case $choice in
    *Lock)     exec hyprlock ;;
    *Suspend)  exec systemctl suspend ;;
    *Reboot)   exec systemctl reboot ;;
    *Shutdown) exec systemctl poweroff ;;
    *)         return 1 ;;
  esac
}

while true; do
  choice=$(printf '1 - Apps\n2 - Files\n3 - Papes\n4 - System' \
           | rofi -dmenu -i -no-custom -p "Menu" \
                  -theme-str 'inputbar {enabled: false;} listview {lines: 4;}') || exit 0
  case $choice in
    *Apps)  rofi -show drun -show-icons -theme-str 'entry {placeholder: "Run...";}  window {width: 48ch;}' && exit 0 ;;
    *Files) files && exit 0 ;;
    *Papes) wallpapers && exit 0 ;;
    *System) system && exit 0 ;;
  esac
done