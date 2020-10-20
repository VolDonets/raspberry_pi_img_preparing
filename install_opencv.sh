#!/bin/bash

mkdir ~/prepare_rpi
cd ~/prepare_rpi

sudo apt-get -y purge wolfram-engine
sudo apt-get -y purge libreoffice*
sudo apt-get -y clean
sudo apt-get -y autoremove


sudo apt-get install libjpeg-dev -y 
sudo apt-get install libpng-dev -y
sudo apt-get install libtiff-dev -y

sudo apt-get install libavcodec-dev -y
sudo apt-get install libavformat-dev -y
sudo apt-get install libswscale-dev -y
sudo apt-get install libv4l-dev -y

sudo apt-get install libxvidcore-dev -y
sudo apt-get install libx264-dev -y

sudo apt-get install libgtk-3-dev -y

sudo apt-get install libcanberra-gtk* -y

sudo apt-get install libatlas-base-dev -y
sudo apt-get install gfortran -y


sudo apt-get install python3-dev -y
sudo apt-get install python3-pip -y
sudo -H pip3 install -U pip numpy
sudo apt-get install python3-testresources -y
sudo apt-get install python3-venv -y

sudo apt-get autoremove -y

cvVersion="master"
python3 -m venv OpenCV-"$cvVersion"-py3
echo "alias workoncv-$cvVersion=\"source $cwd/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bashrc
source OpenCV-"$cvVersion"-py3/bin/activate

sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
pip install numpy dlib

deactivate

wget -O opencv.zip https://github.com/opencv/opencv/archive/4.0.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.0.0.zip
unzip opencv.zip
unzip opencv_contrib.zip
rm opencv.zip
rm opencv_contrib.zib
mv opencv-4.0.0 opencv
mv opencv_contrib-4.0.0 opencv_contrib


cd opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	-D ENABLE_NEON=ON \
	-D ENABLE_VFPV3=ON \
	-D BUILD_TESTS=OFF \
	-D OPENCV_ENABLE_NONFREE=ON \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D BUILD_EXAMPLES=OFF  \
	-D OPENCV_PYTHON3_INSTALL_PATH=../../OpenCV-master-py3/lib/python3.7 \
	..

make -j4
sudo make install
sudo ldconfig

sudo sed -i 's/CONF_SWAPSIZE=1024/CONF_SWAPSIZE=100/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start


