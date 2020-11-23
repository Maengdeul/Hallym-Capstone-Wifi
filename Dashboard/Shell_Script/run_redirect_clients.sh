#!/bin/bash

# /home/wimon/run_redirect_clients.sh
# Run redirect_clients.sh in OpneWrt

# $1 = OpenWrt mac address
# $2 = device mac address

device_mac="$1"
AP_mac="$2"

#OpenWRT1(IP: 211.210.92.69)
#mac address ban shell start
ssh root@211.210.92.69 /etc/config/redirect_clients.sh $device_mac $AP_mac

#OpenWRT2(IP: 211.210.92.69 -p1818)
#mac address ban shell start
ssh root@211.210.92.69 -p1818 /etc/config/redirect_clients.sh $device_mac $AP_mac


#OpenWRT3(IP: 116.42.53.54 -p12333)
#mac address ban shell start
ssh root@116.42.53.54 -p 12333 test/redirect_clients.sh $device_mac $AP_mac

#OpenWRT4(IP: 116.42.53.54 -p12334)
#mac address ban shell start
ssh root@116.42.53.54 -p12334 test/redirect_clients.sh $device_mac $AP_mac
