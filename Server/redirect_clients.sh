#!/bin/sh

# /etc/config/redirect_clients.sh
# Make clients connect the specific AP
# $1: Client's MAC address, $2: Target AP's MAC address

# list all wireless network interfaces

list=`iwinfo | grep ESSID | cut -f 1 -s -d" "`
mlist=`ifconfig -a | grep wlan | cut -c 39-`

for interface in $list
do
  maclist=`iwinfo $interface assoclist | grep dBm | cut -f 1 -s -d" "`
  for mac in $maclist
  do
    host=`cat /tmp/dhcp.leases | cut -f 2,3,4 -s -d" " | grep -i $mac | cut -f 3 -s -d" "`
    for i in $mlist
    do
      if [ $1 == $mac -a $2 != $i ] ; then
        ubus call hostapd.$interface del_client "{'addr':'$mac','reason':0,'deauth':false,'ban_time':60000}"
        uci set wireless.default_radio1.macfilter=deny
        uci add_list wireless.default_radio1.maclist=$1
        uci commit wireless
        luci-reload
        echo "Handover $1 completely!(from ${i})"
      fi
    done
  done
done

sleep 1m

uci del wireless.default_radio1.macfilter
uci del wireless.default_radio1.maclist
uci commit wireless
luci-reload
