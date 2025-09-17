#!/bin/sh

if [ "$BLOCK_BUTTON" -eq 1 ]; then
    kitty --title "calendar" --override font_size=14 bash -c 'cal -SYwc 4; echo; read -n1 -s -r -p "Press any key to close..."'
fi

# Show current time in the bar
date "+%Y/%m/%d %H:%M:%S"
