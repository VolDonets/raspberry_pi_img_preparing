#!/bin/bash

sudo apt-get install gstreamer1.0-tools -y
sudo apt-get install gstreamer1.0-nice -y
sudo apt-get install gstreamer1.0-plugins-bad -y
sudo apt-get install gstreamer1.0-plugins-ugly -y
sudo apt-get install gstreamer1.0-plugins-good -y
sudo apt-get install libgstreamer1.0-dev -y
# this one contains webrtc plugin for the gst pipeline
sudo apt-get install libgstreamer-plugins-bad1.0-dev -y

sudo apt-get install gstreamer1.0-plugins-base
sudo apt-get install gstreamer1.0-libav
sudo apt-get install gstreamer1.0-doc
sudo apt-get install gstreamer1.0-tools
sudo apt-get install gstreamer1.0-x 
sudo apt-get install gstreamer1.0-alsa
sudo apt-get install gstreamer1.0-gl
sudo apt-get install gstreamer1.0-gtk3
sudo apt-get install gstreamer1.0-pulseaudio


# This one used for woring an WEBRTC code on C++
sudo apt-get install libglib2.0-dev -y
sudo apt-get install libsoup2.4-dev -y
sudo apt-get install libjson-glib-dev -y

# This one used in OpenCV lib
sudo apt-get install libgstreamer0.10-dev -y
sudo apt-get install libgstreamer-plugins-base0.10-dev -y
sudo apt-get install libgstreamer-plugins-base1.0-dev

# This one used for installing 
sudo apt-get isntall gstreamer1.0-omx -y

# Updating openssl configuration for posibility to work with WEBRTC connection
echo "export OPENSSL_CONF=\"\"" >> ~/.bashrc
