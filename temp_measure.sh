#!/bin/bash

while [ true ]; do
        clear
        echo "Current temperature: "
        vcgencmd measure_temp
#       echo "CPU usage: "
#       grep cpu /proc/stat
        sleep 1
done
