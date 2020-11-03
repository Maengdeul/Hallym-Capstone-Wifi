#!/bin/bash

#Run script as root
if [ $(id -u) -ne 0 ]; then exec sudo bash "$0" "$@"; exit; fi

#Change directory to usb devices.
cd /sys/bus/usb/devices

#Find device's ID number what you want to remove
device_id=`lsusb | grep -e GEMBIRD | cut -c 24-27`

#Find device's directory
grep_directory=`grep ${device_id} */idVendor | cut -d"/" -f 1`

sudo echo 0 > /sys/bus/usb/devices/${grep_directory}/bConfigurationValue
