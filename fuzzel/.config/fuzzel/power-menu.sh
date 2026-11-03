#!/bin/bash

SELECTION="$(printf " Lock\n󰤄 Suspend\n󰍃 Log out\n󰑙 Reboot\n Shutdown" | fuzzel --dmenu --width 12 -l 6 -p "System: ")"

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
