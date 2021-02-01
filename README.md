# My raspberry pi image preparing

## PROJECT STRUCTURE

* *sh* __'initial_rpi_preparing.sh'__ - this script contains commands for updating and upgrating OS. RECOMMENDED after runnign it reboot your Rasbperry.
* *sh* __'install_cpp_stuff.sh'__ - this script contains commands for installing c/c++ conpile, build, make stuff, also it installs yasm and unzip utilites.
* *sh* __'install_gstreamer.sh'__ - this script contains commands for intalling gstreamer lib for repository. Especially look at webrtc plugin and omx pligin for using hardware encoding.
* *sh* __'install_intel_realsense2.sh'__ - this script contains commands for building and installing realsense2 lib for working with it.
* *sh* __'install_opencv.sh'__ - this script contains commands for building and installing opencv4.2, which are unavailable on the repository.
* *sh* __'install_seasocks.sh'__ - this script contains commands for building and installing seasocks - a lite webrts lib, useful for tiny devices, like raspberry.
* *sh* __'main.sh'__ - this script, I wanted to make as a single shot (run and configure everything), but now I'm to lazy, so it's empty.
* *sh* __'set_wifi_access_point.sh'__ - this script contains commands for intalling and configuring some stuff for initializing access point on the rasbperry.
* *sh* __'temp_measure.sh'__ - this script contains commands for showing current temperature each 1 second. It's easy to configure as your wish.
