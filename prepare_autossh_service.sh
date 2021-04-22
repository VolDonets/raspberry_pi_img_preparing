#!/bin/bash

# you should run this script with root priviligies

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# than set a remoute and a local ports

if [ "$1" == "" ] | [ "$2" == "" ]; then
   echo "WARNING!!! you should set parameters for this script:"
   echo "the fist is REMOUTE PORT"
   echo "the second is LOCAL PORT"
   exit 1
else
   echo "REMOUTE PORT: $1"
   echo "LOCAL   PORT: $2"
fi


echo ""
echo "Creating an SSH key ..."

ssh-keygen
ssh-copy-id root@194.37.80.48


echo ""
echo "Creating a systemd service ..."

SERVICE_PATH="/etc/systemd/system/autossh-tunnel.service"
echo "[Unit]" > $SERVICE_PATH
echo "Description=AutoSSH tunnel service Remote port $1 to local $2" >> $SERVICE_PATH
echo "After=network.target" >> $SERVICE_PATH
echo "" >> $SERVICE_PATH
echo "[Service]" >> $SERVICE_PATH
echo "Restart=on-failure" >> $SERVICE_PATH
echo "Environment=\"AUTOSSH_GATETIME=0\"" >> $SERVICE_PATH
echo "ExecStart=/usr/bin/autossh -o \"ServerAliveInterval 10\" -o \"ServerAliveCountMax 3\" -N -R $1:localhost:$2 root@194.37.80.48" >> $SERVICE_PATH
echo "" >> $SERVICE_PATH
echo "[Install]" >> $SERVICE_PATH
echo "WantedBy=multi-user.target" >> $SERVICE_PATH


echo ""
echo "Starting the systemd service ..."

systemctl daemon-reload
systemctl start autossh-tunnel.service
systemctl enable autossh-tunnel.service
