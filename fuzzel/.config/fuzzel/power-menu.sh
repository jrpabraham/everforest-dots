#!/bin/bash

SELECTION="$(printf " Lock\n󰤄 Suspend\n󰍃 Log out\n󰑙 Reboot\n Shutdown" | fuzzel --dmenu --line-height 20 --width 10 -l 6 --placeholder="System" --hide-prompt)"

case $SELECTION in
    *"Lock")
        hyprlock;;
    *"Suspend")
        systemctl suspend;;
    *"Log out")
        hyperctl dispatch exit;;
    *"Reboot")
        systemctl reboot;;
    *"Shutdown")
        systemctl poweroff;;
esac
