#!/bin/sh

# repo path
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#-------------------------
# Install packages
#-------------------------
install_pkg() {
    if command -v pacman &>/dev/null; then
        echo "Installing packages with pacman..."
        sudo pacman -Syu --noconfirm "$@"

        # pacman exclusive
        sudo pacman -S --noconfirm woff2-font-awesome
        sudo pacman -S --noconfirm pamixer

    elif command -v apt &>/dev/null; then
        echo "Installing packages with apt..."
        sudo apt update -y
        sudo apt install -y "$@"

        # apt exclusive
        sudo apt install -y fonts-font-awesome

        . $DOTFILES/scripts/build_pamixer.sh

    else
        echo "No supported package manager found (pacman/apt)."
        exit 1
    fi
}

#-------------------------
# Packages list
#-------------------------
PKGS=(
    git
    i3-wm
    i3lock
    i3blocks
    xss-lock
    xterm
    lightdm-gtk-greeter
    lightdm
    dmenu
    firefox
    pavucontrol
    kitty
    unzip
    xorg-xrandr
    arandr
    autorandr
    dunst
    rtkit
    curl
    flameshot
    less
)

install_pkg "${PKGS[@]}"

#-------------------------
# Install JetBrainsMono Nerd Font
#-------------------------
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"

mkdir -p "$FONT_DIR"

if ls $FONT_DIR/*JetBrainsMono* >/dev/null 2>&1; then
    echo "$FONT_NAME already installed, skipping."
else
    echo "Installing $FONT_NAME..."

    ZIP="$FONT_DIR/JetBrainsMono.zip"
    curl -L -o "$ZIP" \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip

    unzip -o "$ZIP" -d "$FONT_DIR"
    rm -f "$ZIP"

    fc-cache -fv
    echo "$FONT_NAME installed!"
fi
