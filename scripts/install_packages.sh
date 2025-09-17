#!/bin/sh

# Install packages
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_pkg() {
    local PKG_MGR=""
    if command -v pacman &>/dev/null; then
        PKG_MGR="pacman"
    elif command -v apt &>/dev/null; then
        PKG_MGR="apt"
    else
        echo "No supported package manager found (pacman/apt)." >&2
        exit 1
    fi

    echo "Using $PKG_MGR to install packages..."

    case "$PKG_MGR" in
        pacman)
            sudo pacman -Syu --needed --noconfirm "$@"
            sudo pacman -S --needed --noconfirm "${PKGS_PACMAN[@]}"
            ;;
        apt)
            sudo apt update -y
            sudo apt install -y --ignore-missing "$@"
            sudo apt install -y --ignore-missing "${PKGS_APT[@]}"
            # build pamixer if not packaged
            if ! command -v pamixer &>/dev/null; then
                . "$SCRIPTS_DIR/build_pamixer.sh"
            fi
            ;;
    esac
}

# Shared packages
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
    pamixer
)

# Distro-specific packages
PKGS_PACMAN=(
    woff2-font-awesome
    bash-completion
)

PKGS_APT=(
    fonts-font-awesome
)

install_pkg "${PKGS[@]}"
