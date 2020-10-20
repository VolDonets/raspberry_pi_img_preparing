#!/bin/bash

mkdir ~/prepare_rpi
cd ~/prepare_rpi
git clone https://github.com/mattgodbolt/seasocks
cd seasocks
mkdir build
cd build
cmake ..
make -j4
sudo make install
cd ~/prepare_rpi
rm -rf seasocks
