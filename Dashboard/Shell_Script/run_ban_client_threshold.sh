#!/bin/bash

RX=$1
TX=$2

#OpenWRT1(IP: 192.168.31.202)
#mac address ban threshold shell start
#ssh root@192.168.31.202 /etc/config/ban_client_threshold.sh $RX $TX

#OpenWRT2(IP: 192.168.31.52)
#mac address ban threshold shell start
#ssh root@192.168.31.52 /etc/config/ban_client_threshold.sh $RX $TX

#OpenWRT3(IP: 192.168.31.86 -p12333)
#mac address ban threshold shell start
#ssh root@192.168.31.86 -p 12333 test/ban_client_threshold.sh $RX $TX

#OpenWRT4(IP: 192.168.31.80 -p12334)
#mac address ban threshold shell start
#ssh root@192.168.31.80 -p12334 test/ban_client_threshold.sh $RX $TX
