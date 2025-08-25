#!/bin/sh

# Handle clicks
case $BLOCK_BUTTON in
    1) pavucontrol & disown ;;                        # Left click → open pavucontrol
    3) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;  # Right click → mute toggle
    4) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0 ;; # Scroll up
    5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;   # Scroll down
esac

# Get current volume + mute status
out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null) || out=""
if [ -z "$out" ]; then
    # i3blocks output (3 lines: full, short, color)
    echo "󰸈 N/A"
    echo "󰸈 N/A"
    echo "#ff5555"
    exit 0
fi

# Parse volume and mute
vol=$(awk '{print int($2*100)}' <<< "$out")
mute=$(grep -q MUTED <<< "$out" && echo 1 || echo 0)

# Choose icon
if (( mute )); then
    icon=""
    color="#ff5555"
else
    if   (( vol == 0 )); then icon=""
    elif (( vol < 50 )); then icon=""
    else icon=""
    fi
    color="#aaffaa"
fi

# i3blocks output (3 lines: full, short, color)
echo "$icon   $vol%"
echo "$icon   $vol%"
echo "$color"
