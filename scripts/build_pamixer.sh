#!/bin/sh

# Builds pamixer from source in apt

# Install build dependencies
sudo apt install -y build-essential cmake libpulse-dev git
# Clone pamixer
git clone https://github.com/cdemoulins/pamixer.git ~/pamixer
cd ~/pamixer

# Build pamixer
mkdir build && cd build
cmake ..
make
sudo make install

# Add pamixer executable to PATH
echo 'export PATH="$HOME/pamixer/build:$PATH"' >> ~/.xprofile
