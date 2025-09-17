#!/bin/sh

# Install JetBrainsMono Nerd Font 
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"

mkdir -p "$FONT_DIR"

if ls $FONT_DIR/*JetBrainsMono* >/dev/null 2>&1; then
    echo "$FONT_NAME already installed, skipping."
else
    echo "Installing $FONT_NAME..."

    ZIP="$FONT_DIR/JetBrainsMono.zip"
    curl -L -o "$ZIP" $FONT_URL

    unzip -o "$ZIP" -d "$FONT_DIR"
    rm -f "$ZIP"

    fc-cache -fv
    echo "$FONT_NAME installed!"
fi
