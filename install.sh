#!/bin/sh

# repo path
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# i3wm config
I3_CONFIG=".config/i3/config"
mkdir -p $HOME/$(dirname "$I3_CONFIG")
rm $HOME/$I3_CONFIG
ln -s $DOTFILES/$I3_CONFIG $HOME/$I3_CONFIG

# i3blocks config
I3_BLOCKS=".config/i3blocks/config"
mkdir -p $HOME/$(dirname "$I3_BLOCKS")
rm $HOME/$I3_BLOCKS 2>/dev/null
ln -s $DOTFILES/$I3_BLOCKS $HOME/$I3_BLOCKS

# i3blocks time config
I3_BLOCKS_TIME=".config/i3blocks/time/time.sh"
mkdir -p $HOME/$(dirname "$I3_BLOCKS_TIME")
rm $HOME/$I3_BLOCKS_TIME 2>/dev/null
ln -s $DOTFILES/$I3_BLOCKS_TIME $HOME/$I3_BLOCKS_TIME

# i3blocks volume config
I3_BLOCKS_VOLUME=".config/i3blocks/volume/volume.sh"
mkdir -p $HOME/$(dirname "$I3_BLOCKS_VOLUME")
rm $HOME/$I3_BLOCKS_VOLUME 2>/dev/null
ln -s $DOTFILES/$I3_BLOCKS_VOLUME $HOME/$I3_BLOCKS_VOLUME
