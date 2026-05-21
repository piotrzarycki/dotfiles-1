#!/bin/bash
LID_STATE=$(grep -oP "closed|open" /proc/acpi/button/lid/LID1/state)
IS_HOME=$(hyprctl monitors | grep "499P9")
EXTERNAL_MONITORS=$(hyprctl monitors | grep "Monitor" | grep -v "eDP-1" | wc -l)

if [ "$LID_STATE" == "open" ]; then
    if [ -n "$IS_HOME" ]; then
        hyprctl keyword monitor "eDP-1, 2880x1800@90, 1440x1440, 2"
    else
        hyprctl keyword monitor "eDP-1, preferred, auto, 2"
    fi
else
    if [ "$EXTERNAL_MONITORS" -gt 0 ]; then
        hyprctl keyword monitor "eDP-1, disable"
    else
        systemctl suspend
    fi
fi
