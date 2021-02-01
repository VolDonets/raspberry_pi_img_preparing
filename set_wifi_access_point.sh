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


# Install NetworkManager, now it doesn't available on the clean RaspbianOS
sudo apt-get install network-manager -y
sudo apt-get install dnsmasq -y

# Disabling standalone dnsmasq service
# Dnsmasq is a lightweight DNS forwarder and DHCP server.
# By default dnsmasq runs as a standalone service and will conflict with dnsmasq instance
#    launched by NetworkManager.
# To prevent the conflict, disable dnsmasq service by running the following commands:
sudo systemctl disable dnsmasq
sudo systemctl stop dnsmasq

# For NetworkManager to run dnsmasq as a local caching DNS server
sudo echo "[main]"                    > /etc/NetworkManager/NetworkManager.conf
sudo echo "plugins=ifupdown,keyfile" >> /etc/NetworkManager/NetworkManager.conf
sudo echo "dns=dnsmasq"              >> /etc/NetworkManager/NetworkManager.conf
sudo echo ""                         >> /etc/NetworkManager/NetworkManager.conf
sudo echo "[ifupdown]"               >> /etc/NetworkManager/NetworkManager.conf
sudo echo "managed=false"            >> /etc/NetworkManager/NetworkManager.conf

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



