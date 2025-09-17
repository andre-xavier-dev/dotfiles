#!/bin/sh

# repo path
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. $DOTFILES/scripts/install_packages.sh

. $DOTFILES/scripts/install_font.sh

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
