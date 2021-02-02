#!/bin/bash

if [ "$1" == "" ] | [ "$2" == "" ]; then
   echo "WARNING!!! you should set parameters for this script:"
   echo "the fist is WIFI_ACCESS_POINT_NAME"
   echo "the second is WIFI_ACCESS_POINT_PASSWORD"
   exit 1
else
   if [ ${#2} -le 7 ]; then
      echo "WiFi PASSWORD is too short, it should be 8 or greater"
      exit 1
   fi
   echo "WiFi name: $1"
   echo "WiFi pass: $2"
fi

sleep 2

# Install NetworkManager, now it doesn't available on the clean RaspbianOS
sudo apt-get update
sudo apt-get install network-manager -y
sudo apt-get install network-manager-gnome -y
sudo apt-get install dnsmasq -y

# Disabling standalone dnsmasq service
# Dnsmasq is a lightweight DNS forwarder and DHCP server.
# By default dnsmasq runs as a standalone service and will conflict with dnsmasq instance
#    launched by NetworkManager.
# To prevent the conflict, disable dnsmasq service by running the following commands:
sudo systemctl disable dnsmasq
sudo systemctl stop dnsmasq

sleep 1

# For NetworkManager to run dnsmasq as a local caching DNS server
sudo echo "[main]"                    > /etc/NetworkManager/NetworkManager.conf
sudo echo "plugins=ifupdown,keyfile" >> /etc/NetworkManager/NetworkManager.conf
sudo echo "dns=dnsmasq"              >> /etc/NetworkManager/NetworkManager.conf
sudo echo "dhcp=internal"            >> /etc/NetworkManager/NetworkManager.conf
sudo echo ""                         >> /etc/NetworkManager/NetworkManager.conf
sudo echo "[ifupdown]"               >> /etc/NetworkManager/NetworkManager.conf
sudo echo "managed=true"             >> /etc/NetworkManager/NetworkManager.conf

# disable wpa managing for wlan0
sudo echo "denyinterfaces wlan0"     > /etc/dhcpd.conf

# restart network-manager
sudo systemctl restart network-manager.service


# print information about available devices
echo "\n\n <----------------------------------------> \n\n"
sudo nmcli dev
echo "\n\n <----------------------------------------> \n\n"

sleep 1

# for configuring wi-fi ap, name, pass, and other wi-if stuff
nmcli con add type wifi ifname wlan0 mode ap con-name "$1" ssid "$1"
nmcli con modify "$1" 802-11-wireless.band bg
nmcli con modify "$1" 802-11-wireless.channel 1
nmcli con modify "$1" 802-11-wireless-security.key-mgmt wpa-psk
nmcli con modify "$1" 802-11-wireless-security.proto rsn
nmcli con modify "$1" 802-11-wireless-security.group ccmp
nmcli con modify "$1" 802-11-wireless-security.pairwise ccmp
nmcli con modify "$1" 802-11-wireless-security.psk "$2"
nmcli con modify "$1" ipv4.method shared
nmcli con up "$1"

# reboot raspberry pi
read -p "Reboot now Y/n: " USER_CHOISE
if [ "$USER_CHOISE" == "y"] | [ "$USER_CHOISE" == "Y" ] | [ "$USER_CHOISE" == "" ]; then
   echo "Rebooting ..."
   sudo reboot
else
   echo "Please REBOOT whet it'll be comfortable"
fi
