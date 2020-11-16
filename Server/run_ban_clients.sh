#!/bin/bash

MAC="$@"

#OpenWRT1(IP: 211.210.92.69)
#mac address ban shell start
ssh root@211.210.92.69 /etc/config/ban_clients.sh $MAC 


#OpenWRT2(IP: 211.210.92.69 -p1818)
#mac address ban shell start
#ssh root@211.210.92.69 -p1818 /etc/config/ban_clients.sh $MAC 


#OpenWRT3(IP: 116.42.53.54 -p12333)
#mac address ban shell start
#ssh root@116.42.53.54 -p12333 test/ban_mac.sh $MAC


#OpenWRT4(IP: 116.42.53.54 -p12334) 
#mac address ban shell start 
#ssh root@116.42.53.54 -p12334 test/ban_mac.sh $MAC

