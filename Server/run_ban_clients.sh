#!/bin/bash

MAC="$@"

#OpenWRT1(IP: 192.168.31.202)
#mac address ban shell start
ssh root@192.168.31.202 /etc/config/ban_clients.sh $MAC

#OpenWRT2(IP: 192.168.31.52)
#mac address ban shell start
ssh root@192.168.31.52 /etc/config/ban_clients.sh $MAC 

#OpenWRT3(IP: 192.168.31.86 -p12333)
#mac address ban shell start
ssh root@192.168.31.86 -p 12333 test/ban_clients.sh $MAC

#OpenWRT4(IP: 192.168.31.80 -p12334) 
#mac address ban shell start 
ssh root@192.168.31.80 -p12334 test/ban_clients.sh $MAC
