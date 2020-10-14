#!/bin/sh

# /etc/config/modified_show_wifi_clients.sh
# Shows MAC, IP address, RX/TX and any hostname info for all connected wifi devices
# written for openwrt 12.09 Attitude Adjustment

echo    "# All connected wifi devices, with IP address,"
echo    "# hostname (if available), MAC address, and RX/TX"
echo -e "# No.\tIP address\t\tname\t\t\tMAC address\t\tRX\t\tTX"

num=1

# list all wireless network interfaces
# (for universal driver; see wiki article for alternative commands)
for interface in `iwinfo | grep ESSID | cut -f 1 -s -d" "`
do
  # for each interface, get mac addresses of connected stations/clients
  maclist=`iwinfo $interface assoclist | grep dBm | cut -f 1 -s -d" "`
  # for each mac address in that list...
  for mac in $maclist
  do
    # If a DHCP lease has been given out by dnsmasq,
    # save it.
    ip="UNKN"
    host=""
    ip=`cat /tmp/dhcp.leases | cut -f 2,3,4 -s -d" " | grep -i $mac | cut -f 2 -s -d" "`
    host=`cat /tmp/dhcp.leases | cut -f 2,3,4 -s -d" " | grep -i $mac | cut -f 3 -s -d" "`
    rx=`iwinfo $interface assoclist | grep -A $num $mac | grep RX | cut -f 2 -s -d" "`
    tx=`iwinfo $interface assoclist | grep -A $((num+1)) $mac | grep TX | cut -f 2 -s -d" "`
    # ... show the mac address with RX, TX:
    echo -e "  $num\t$ip\t\t$host\t$mac\t$rx Mbits/s\t$tx Mbits/s"
    num=$((num+1))
  done
done