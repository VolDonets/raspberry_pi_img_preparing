#!/bin/bash

sudo apt-get install gstreamer1.0-tools -y
sudo apt-get install gstreamer1.0-nice -y
sudo apt-get install gstreamer1.0-plugins-bad -y
sudo apt-get install gstreamer1.0-plugins-ugly -y
sudo apt-get install gstreamer1.0-plugins-good -y
sudo apt-get install libgstreamer1.0-dev -y
# this one contains webrtc plugin for the gst pipeline
sudo apt-get install libgstreamer-plugins-bad1.0-dev -y

sudo apt-get install gstreamer1.0-plugins-base -y
sudo apt-get install gstreamer1.0-libav -y
sudo apt-get install gstreamer1.0-doc -y
sudo apt-get install gstreamer1.0-tools -y
sudo apt-get install gstreamer1.0-x -y
sudo apt-get install gstreamer1.0-alsa -y
sudo apt-get install gstreamer1.0-gl -y
sudo apt-get install gstreamer1.0-gtk3 -y
sudo apt-get install gstreamer1.0-pulseaudio -y


# This one used for woring an WEBRTC code on C++
sudo apt-get install libglib2.0-dev -y
sudo apt-get install libsoup2.4-dev -y
sudo apt-get install libjson-glib-dev -y

# This one used in OpenCV lib
sudo apt-get install libgstreamer0.10-dev -y
sudo apt-get install libgstreamer-plugins-base0.10-dev -y
sudo apt-get install libgstreamer-plugins-base1.0-dev -y

# This one used for installing 
sudo apt-get install gstreamer1.0-omx -y

# Updating openssl configuration for posibility to work with WEBRTC connection
echo "export OPENSSL_CONF=\"\"" >> ~/.bashrc
