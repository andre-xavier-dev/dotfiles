#!/bin/sh

# --- Detect backend ---
if command -v wpctl >/dev/null 2>&1; then
    backend="pipewire"
elif command -v pactl >/dev/null 2>&1; then
    backend="pulseaudio"
else
    echo "󰸈 N/A"
    echo "󰸈 N/A"
    echo "#ff5555"
    exit 1
fi

# --- Handle clicks ---
case $BLOCK_BUTTON in
    1) pavucontrol & disown ;;   # Left click → open pavucontrol
esac

if [ "$backend" = "pipewire" ]; then
    case $BLOCK_BUTTON in
        3) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
        4) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0 ;;
        5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
    esac

    out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null) || out=""
    if [ -z "$out" ]; then
        echo "󰸈 N/A"; echo "󰸈 N/A"; echo "#ff5555"; exit 0
    fi

    vol=$(awk '{print int($2*100)}' <<< "$out")
    mute=$(grep -q MUTED <<< "$out" && echo 1 || echo 0)

else # PulseAudio
    case $BLOCK_BUTTON in
        3) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
        4) pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
        5) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
    esac

    sink=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')
    out=$(pactl list sinks | awk -v s="$sink" '
        $0 ~ "Name: "s {f=1}
        f && /Volume:/ && !vol {vol=$5}
        f && /Mute:/   {mute=$2; print vol, mute; exit}
    ')

    if [ -z "$out" ]; then
        echo "󰸈 N/A"; echo "󰸈 N/A"; echo "#ff5555"; exit 0
    fi

    vol=$(echo "$out" | awk '{print $1}' | tr -d '%')
    mute=$(echo "$out" | awk '{print $2}')
    [ "$mute" = "yes" ] && mute=1 || mute=0
fi

# --- Choose icon + color ---
if [ "$mute" -eq 1 ]; then
    icon=""
    color="#ff5555"
else
    if   [ "$vol" -eq 0 ]; then icon=""
    elif [ "$vol" -lt 50 ]; then icon=""
    else icon=""
    fi
    color="#aaffaa"
fi

# --- i3blocks output ---
echo "$icon   ${vol}%"
echo "$icon   ${vol}%"
echo "$color"
