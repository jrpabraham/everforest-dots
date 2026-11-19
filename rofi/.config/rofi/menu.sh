#!/bin/bash
row() { printf '%s\0info\x1f%s\n' "$1" "$2"; }

show() {
  case "$1" in
    power)
      printf '\0prompt\x1fPower\n'
      row "Lock"      "run:hyprlock"
      row "Suspend"   "run:systemctl suspend"
      row "Reboot"    "run:systemctl reboot"
      row "Shutdown"  "run:systemctl poweroff"
      row "Back"      "menu:main"
      row "Files" "run:$HOME/.config/rofi/search.sh"
      ;;
    *)
      printf '\0prompt\x1fMenu\n'
      row "Power"      "menu:power"
      row "Wallpaper"  "run:$HOME/.config/hypr/wallpaper.sh"
      ;;
  esac
}

case "$ROFI_INFO" in
  menu:*) show "${ROFI_INFO#menu:}" ;;
  run:*)  setsid sh -c "${ROFI_INFO#run:}" >/dev/null 2>&1 & ;;
  *)      show main ;;
esac