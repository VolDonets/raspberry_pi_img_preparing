#!/bin/bash

sudo apt-get update
sudo apt-get dist-upgrade -y

sudo apt-get install automake -y
sudo apt-get install libtool -y
sudo apt-get install vim -y
sudo apt-get install cmake -y
sudo apt-get install libusb-1.0-0-dev -y
sudo apt-get install libx11-dev -y
sudo apt-get install xorg-dev -y
sudo apt-get install libglu1-mesa-dev -y

# if swap file was 100Mb
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile
# if swap file was 1024Mb
sudo sed -i 's/CONF_SWAPSIZE=1024/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

mkdir ~/prepare_rpi
cd ~/prepare_rpi

git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/ 

sudo su
udevadm control --reload-rules && udevadm trigger
exit

echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc

cd ~/prepare_rpi
git clone --depth=1 -b v3.10.0 https://github.com/google/protobuf.git
cd protobuf
./autogen.sh
./configure
make -j1
sudo make install
cd python
export LD_LIBRARY_PATH=../src/.libs
python3 setup.py build --cpp_implementation 
python3 setup.py test --cpp_implementation
sudo python3 setup.py install --cpp_implementation
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=3
sudo ldconfig
protoc --version

cd ~/prepare_rpi
wget https://github.com/PINTO0309/TBBonARMv7/raw/master/libtbb-dev_2018U2_armhf.deb
sudo dpkg -i ~/prepare_rpi/libtbb-dev_2018U2_armhf.deb
sudo ldconfig
rm libtbb-dev_2018U2_armhf.deb

cd ~/prepare_rpi/librealsense
mkdir  build  && cd build
cmake .. -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=Release -DFORCE_LIBUVC=true
make -j4
sudo make install

cd ~/prepare_rpi/librealsense/build
cmake .. -DBUILD_PYTHON_BINDINGS=bool:true -DPYTHON_EXECUTABLE=$(which python3)
make -j1
sudo make install

echo "export PYTHONPATH=$PYTHONPATH:/usr/local/lib" >> ~/.bashrc
source ~/.bashrc

sudo apt-get install python-opengl
sudo -H pip3 install pyopengl
sudo -H pip3 install pyopengl_accelerate==3.1.3rc1

# enable openGL
#sudo raspi-config
#"7. Advanced Options" – "A8 GL Driver" – "G2 GL (Fake KMS)"

# enable VNC
#"3. Boot Options" – "B1 Desktop/CLI" – "B4 Desktop Autologin"
#"5. Interfacing Options" – "P3 VNC" – "Yes"
#"7. Advanced Options" – "A5 Resolution" – "DMT Mode 85 1280X720 60Hz 16:9"

