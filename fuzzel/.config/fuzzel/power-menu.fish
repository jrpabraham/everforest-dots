#!/usr/bin/env fish

# --- Fuzzel Power Menu for Fish Shell ---

# Define menu options
set options "Logout" "Lock" "Shutdown" "Reboot" "Suspend"

# Show menu in Fuzzel
set chosen (printf "%s\n" $options | fuzzel -i -p "Power Menu:")

# Execute the selected option
switch $chosen
    case "Logout"
        /usr/bin/hyprctl dispatch exit
    case "Lock"
        /usr/bin/swaylock
    case "Shutdown"
        /usr/bin/systemctl poweroff
    case "Reboot"
        /usr/bin/systemctl reboot
    case "Suspend"
        /usr/bin/systemctl suspend
end