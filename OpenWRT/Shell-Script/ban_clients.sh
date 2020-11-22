#!/bin/sh

# /etc/config/ban_clients.sh
# Set the limit, ban time  and ban clients who over the limit

# list all wireless network interfaces

list=`iwinfo | grep ESSID | cut -f 1 -s -d" "`

for interface in $list
do
  maclist=`iwinfo $interface assoclist | grep dBm | cut -f 1 -s -d" "`
  for mac in $maclist
  # for each interface, get RX/TX of connected stations/clients
  do
    if [ $1 == ${mac} ]; then
      ubus call hostapd.$interface del_client "{'addr':'$mac','reason':0,'deauth':false,'ban_time':60000}"
      uci set wireless.default_radio1.macfilter=deny
      uci add_list wireless.default_radio1.maclist=$1
      uci commit wireless
      luci-reload
      echo "client banned"
    fi
  done
done

sleep 1m

uci del wireless.default_radio1.macfilter
uci del wireless.default_radio1.maclist
uci commit wireless
luci-reload
