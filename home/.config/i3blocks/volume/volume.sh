#!/bin/sh

# Handle clicks
case $BLOCK_BUTTON in
    1) pavucontrol & disown ;; # Left click  -> open pavucontrol
    3) pamixer -t ;;           # Right click -> mute toggle
    4) pamixer --increase 5 ;; # Scroll up   -> volume +5%
    5) pamixer --decrease 5 ;; # Scroll down -> volume -5%
esac

# Get current volume and mute status
if ! vol=$(pamixer --get-volume 2>/dev/null); then
    # i3blocks output (3 lines: full, short, color)
    echo "󰸈 N/A"
    echo "󰸈 N/A"
    echo "#ff5555"
    exit 0
fi

mute=$(pamixer --get-mute)

# Choose icon
if [ "$mute" = "true" ]; then
    icon="  "
    color="#ff5555"
else
    if   [ "$vol" -eq 0 ]; then icon="  "
    elif [ "$vol" -lt 50 ]; then icon="  "
    else icon="  "
    fi
    color="#aaffaa"
fi

# i3blocks output (3 lines: full, short, color)
echo "$icon ${vol}%"
echo "$icon ${vol}%"
echo "$color"
