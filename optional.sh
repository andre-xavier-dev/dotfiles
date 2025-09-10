#!/bin/sh

#-------------------------
# Install packages
#-------------------------
install_pkg() {
    if command -v pacman &>/dev/null; then
        echo "Installing packages with pacman..."
        sudo pacman -Syu --noconfirm "$@"

        # pacman exclusive
        sudo pacman -S bash-completion

    elif command -v apt &>/dev/null; then
        echo "Installing packages with apt..."
        sudo apt update -y
        sudo apt install -y "$@"

        # apt exclusive

    else
        echo "No supported package manager found (pacman/apt)."
        exit 1
    fi
}

#-------------------------
# Packages list
#-------------------------
PKGS=(
    xorg-xrandr
)

install_pkg "${PKGS[@]}"

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
