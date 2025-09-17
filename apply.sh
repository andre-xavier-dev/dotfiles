#!/bin/sh

# repo path
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/home"

# Adding configs to the list
# Paths are relative to home folder
CONFIGS=(
    ".gitconfig"
    ".config/i3/config"
    ".config/i3blocks/config"
    ".config/i3blocks/time/time.sh"
    ".config/i3blocks/volume/volume.sh"
    ".config/kitty/kitty.conf"
    ".config/kitty/current-theme.conf"
    ".bashrc"
    ".bash_profile"
    ".bash_aliases"
)

# Link multiple configs at once
link_configs() {
    for rel_path in "$@"; do
        local target="$HOME/$rel_path"
        local source="$DOTFILES/$rel_path"

        # Ensure the parent directory exists
        mkdir -p "$(dirname "$target")"

        # Remove any existing file or symlink
        rm -f "$target"

        # Create the symlink
        ln -s "$source" "$target"

        echo "Linked $target → $source"
    done
}

# Linking configs
link_configs "${CONFIGS[@]}"
