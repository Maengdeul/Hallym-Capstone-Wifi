#echo    "# All connected wifi devices, with IP address,"
#echo    "# hostname (if available), MAC address, RX/TX info, and Expected throughput"

# list all wireless network interfaces
# (for universal driver; see wiki article for alternative commands)
num=1
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
    rb=`iw dev wlan1 station get $mac | grep "rx bytes:" | cut -f 2 -s -d" " | cut -f 2`
    rp=`iw dev wlan1 station get $mac | grep "rx packets:" | cut -f 2 -s -d" " | cut -f 2`
    tx=`iwinfo $interface assoclist | grep -A $((num+1)) $mac | grep TX | cut -f 2 -s -d" "`
    tb=`iw dev wlan1 station get $mac | grep "tx bytes:" | cut -f 2 -s -d" " | cut -f 2`
    tp=`iw dev wlan1 station get $mac | grep "tx packets:" | cut -f 2 -s -d" " | cut -f 2`
    et=`iwinfo $interface assoclist | grep -A $((num+2)) $mac | grep expected | cut -f 3 -s -d" "`
    # ... show the mac address with RX, TX info and expected throughput:
    #echo -e "  IP address\t\tname\t\t\tMAC address\t\tRX\t\tTX\t\tRX bytes\tRX packets\tTX bytes\tTX packets\t Expected throughput"
    echo -e "$ip\t\t$host\t$mac\t$rx MBits/s\t$tx MBits/s\t$rb\t\t$rp\t\t$tb\t\t$tp\t\t $et Mbps"
    # If file which saves MAC address does not exist,
    # make one and save MAC address
    check_mac=1
    if [ -f "$/etc/config/maclist.txt" ]; then
      for LIST in `cat /etc/config/maclist.txt`
      do
        if [ $LIST == $mac ]; then
          check_mac=0
          break
        fi
      done
    else
      `touch /etc/config/maclist.txt`
      for LIST in `cat /etc/config/maclist.txt`
      do
        if [ $LIST == $mac ]; then
          check_mac=0
          break
        fi
      done
    fi
    if [ $check_mac -eq 1 ]; then
      echo $mac >> maclist.txt
    fi
  done
done
