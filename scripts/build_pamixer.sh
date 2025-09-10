#!/bin/sh

# apt only, installs pamixer
sudo apt install -y build-essential cmake libpulse-dev git
# Clone pamixer
git clone https://github.com/cdemoulins/pamixer.git ~/pamixer
cd ~/pamixer

# Build and install pamixer
mkdir build && cd build
cmake ..
make
sudo make install

# Add pamixer executable to PATH
echo 'export PATH="$HOME/pamixer/build:$PATH"' >> ~/.xprofile
