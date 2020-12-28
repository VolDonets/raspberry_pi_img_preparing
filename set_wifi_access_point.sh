#!/bin/bash

# Install NetworkManager, now it doesn't available on the clean RaspbianOS
sudo apt-get install network-manager -y

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

nmcli dev wifi hotspot ifname wlan0 ssid IronRPI password "test1234"


