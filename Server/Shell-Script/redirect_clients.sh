#!/bin/sh

# /etc/config/redirect_clients.sh
# Make clients connect the specific AP
# $1: Client's MAC address, $2: Target AP's MAC address

# list all wireless network interfaces

list=`iwinfo | grep ESSID | cut -f 1 -s -d" "`
mlist="70:5D:CC:AD:C9:10,70:5D:CC:AD:C9:12,D8:47:32:B3:55:35,D8:47:32:B3:55:36"

for interface in $list
do
  maclist=`iwinfo $interface assoclist | grep dBm | cut -f 1 -s -d" "`
  for mac in $maclist
  do
    host=`cat /tmp/dhcp.leases | cut -f 2,3,4 -s -d" " | grep -i $mac | cut -f 3 -s -d" "`
    for i in `echo ${mlist} | tr ',' '\n'`
    do
      if [ $1 == $mac -a $2 != ${i} ] ; then
        ubus call hostapd.$interface del_client "{'addr':'$mac','reason':5,'deauth':false,'ban_time':10000}"
        echo "$1 banned completely!(from ${i})"
      fi
    done
  done
done