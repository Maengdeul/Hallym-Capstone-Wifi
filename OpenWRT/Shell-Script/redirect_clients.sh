#!/bin/sh

# /etc/config/redirect_clients.sh
# Make clients connect the specific AP
# $1: Client's MAC address, $2: Target AP's MAC address

# list all wireless network interfaces

list=`iwinfo | grep ESSID | cut -f 1 -s -d" "`

mlist=`ifconfig -a | grep wlan | cut -c 39-`  #Your AP mac address
for i in $mlist
do
        if [ $i != $2 ] ; then
                list=`iwinfo | grep ESSID | cut -f 1 -s -d" "`

                for interface in $list
                do
                  maclist=`iwinfo $interface assoclist | grep dBm | cut -f 1 -s -d" "`
                  for mac in $maclist
                  # Ban Clients
                  do
                    if [ $1 == ${mac} ]; then
                      ubus call hostapd.$interface del_client "{'addr':'$mac','reason':0,'deauth':false,'ban_time':10000}"
                      echo "client banned"
                    fi
                  done
                done

                uci set wireless.default_radio1.macfilter='deny'
                uci add_list wireless.default_radio1.maclist='$1'
                uci commit wireless
                luci-reload

                sleep 10

                uci del wireless.default_radio1.macfilter
                uci del wireless.default_radio1.maclist

                uci commit wireless
                luci-reload
                break
        fi
done
