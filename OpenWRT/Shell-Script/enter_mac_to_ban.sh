#!/bin/sh

# /etc/config/ban_clients.sh
# Ban the entered MAC address

# list all wireless network interfaces

list=`iwinfo | grep ESSID | cut -f 1 -s -d" "`

# Enter MAC addr
echo -n "enter MAC addr : "
read macaddr

for interface in $list
do
  maclist=`iwinfo $interface assoclist | grep dBm | cut -f 1 -s -d" "`
  for mac in $maclist
  do
  #Found match MAC address to ban
    if [ ${macaddr} = ${mac} ]; then
      ubus call hostapd.$interface del_client "{'addr':'$mac','reason':0,'deauth':false,'ban_time':500}"
      echo "client banned"
    fi
  done
done
