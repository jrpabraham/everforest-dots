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

power() {
  choice=$(printf ' Lock\n󰤄 Suspend\n󰑙 Reboot\n Shutdown' \
           | rofi -dmenu -i -no-custom -p "Power" -theme-str 'window {width: 24ch;} inputbar {enabled: false;} listview {lines: 4;}') || return 1
  case $choice in
    *Lock)     exec hyprlock ;;
    *Suspend)  exec systemctl suspend ;;
    *Reboot)   exec systemctl reboot ;;
    *Shutdown) exec systemctl poweroff ;;
    *)         return 1 ;;
  esac
}

while true; do
  choice=$(printf '1/ Apps\n2/ Files\n3/ Power\n' \
           | rofi -dmenu -i -no-custom -p "Menu" \
                  -theme-str 'inputbar {enabled: false;} listview {lines: 3;}') || exit 0
  case $choice in
    *Apps)  rofi -show drun -show-icons && exit 0 ;;
    *Files) files && exit 0 ;;
    *Power) power && exit 0 ;;
  esac
done